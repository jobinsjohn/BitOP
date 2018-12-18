//
//  BitOP_PoloniexService.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import Foundation
import Starscream
import NotificationBannerSwift

protocol BitPoloniexServiceListenerProtocol {
    var objectID : Int! {get}
    func receivedUpdates(_ scrip:CurrencyModel)
}

class BitOPPoloniexService {
    static let shared = BitOPPoloniexService()
    fileprivate var socket :WebSocket!
    var observers = [Int:BitPoloniexServiceListenerProtocol]()
    
    init() {
        socket = WebSocket(url: URL(string: "wss://api2.poloniex.com")!)
        //websocketDidConnect
        socket.onConnect = {
            self.socket.write(string: "{\"command\":\"subscribe\",\"channel\":\"1002\"}")
            let banner = StatusBarNotificationBanner(title: "Connected", style: .success)
            banner.dismiss()
            banner.show()
            //print("websocket is connected")
        }
        //websocketDidDisconnect
        socket.onDisconnect = { (error: Error?) in
            let banner = StatusBarNotificationBanner(title: "Diconnected", style: .danger)
            banner.dismiss()
            banner.show()
            print("websocket is disconnected: \(error?.localizedDescription ?? "")")
        }
        //websocketDidReceiveMessage
        socket.onText = { (text: String) in
            //print("got some text: \(text)")
            guard let data = text.data(using: .utf8) else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            guard let count = json??.count ,count > 2 else {return}
            if let tickerinfoAny = json??[2] as? [Any] {
                var tickerinfo = [String]()
                for i in tickerinfoAny {
                    if let newI = i as? String {
                        tickerinfo.append(newI)
                    }else if let newI = i as? Int {
                        tickerinfo.append("\(newI)")
                    }
                }
                let newScrip = CurrencyModel.init(id: Int(tickerinfo[0]) ?? 0,
                                          lastTradePrice: tickerinfo[1],
                                          lowestAsk: tickerinfo[2],
                                          highestBid: tickerinfo[3],
                                          percentChange: tickerinfo[4],
                                          baseVolume: tickerinfo[5],
                                          quoteVolume: tickerinfo[6],
                                          isFrozen: tickerinfo[7],
                                          high24hr: tickerinfo[8],
                                          low24hr: tickerinfo[9])
                print(newScrip)
                self.notifyObservers(updates:newScrip)
            }
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            print("Data Received : \(data.count)")
        }
    }
    func subscribe(_ observer:BitPoloniexServiceListenerProtocol){
        if observers.count == 0 {
            //start the server
            socket.connect()
        }
        observers[observer.objectID] = observer
    }
    func unsubscribe(_ observer:BitPoloniexServiceListenerProtocol){
        observers[observer.objectID] = nil
        if observers.count == 0 {
            //stop the server
            socket.disconnect()
        }
    }
    func notifyObservers(updates scrip:CurrencyModel) {
        for (_,observer) in observers {
            observer.receivedUpdates(scrip)
        }
    }
}
