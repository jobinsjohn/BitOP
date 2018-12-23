//
//  BitOPPoloniexService.swift
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
    fileprivate var socketObj :WebSocket!
    var observers = [Int:BitPoloniexServiceListenerProtocol]()
    
    init() {
        socketObj = WebSocket(url: URL(string: "wss://api2.poloniex.com")!)
        //websocketDidConnect
        socketObj.onConnect = {
            self.socketObj.write(string: "{\"command\":\"subscribe\",\"channel\":\"1002\"}")
            let banner = StatusBarNotificationBanner(title: "Connected", style: .success)
            banner.dismiss()
            banner.show()
            //print("websocket is connected")
        }
        //websocketDidDisconnect
        socketObj.onDisconnect = { (error: Error?) in
            let banner = StatusBarNotificationBanner(title: "Diconnected", style: .danger)
            banner.dismiss()
            banner.show()
            print("websocket is disconnected: \(error?.localizedDescription ?? "")")
        }
        //websocketDidReceiveMessage
        socketObj.onText = { (text: String) in
            //print("got some text: \(text)")
            guard let data = text.data(using: .utf8) else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            guard let count = json??.count ,count > 2 else {return}
            if let scripinfoObj = json??[2] as? [Any] {
                var scripinfo = [String]()
                for i in scripinfoObj {
                    if let newI = i as? String {
                        scripinfo.append(newI)
                    }else if let newI = i as? Int {
                        scripinfo.append("\(newI)")
                    }
                }
                let newScrip = CurrencyModel.init(id: Int(scripinfo[0]) ?? 0,
                                          lastTradePrice: scripinfo[1],
                                          lowestAsk: scripinfo[2],
                                          highestBid: scripinfo[3],
                                          percentChange: scripinfo[4],
                                          baseVolume: scripinfo[5],
                                          quoteVolume: scripinfo[6],
                                          isFrozen: scripinfo[7],
                                          high24hr: scripinfo[8],
                                          low24hr: scripinfo[9])
                self.notifyObservers(updates:newScrip)
            }
        }
        //Received Data from server
        socketObj.onData = { (data: Data) in
            print("Data Received : \(data.count)")
        }
    }
    func subscribe(_ observer:BitPoloniexServiceListenerProtocol){
        if observers.count == 0 {
            //Connect the server
            socketObj.connect()
        }
        observers[observer.objectID] = observer
    }
    func unsubscribe(_ observer:BitPoloniexServiceListenerProtocol){
        observers[observer.objectID] = nil
        if observers.count == 0 {
            //Disconnect the server
            socketObj.disconnect()
        }
    }
    func notifyObservers(updates scrip:CurrencyModel) {
        for (_,observer) in observers {
            observer.receivedUpdates(scrip)
        }
    }
}
