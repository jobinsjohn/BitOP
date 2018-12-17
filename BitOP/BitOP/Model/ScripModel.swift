//
//  ScripModel.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import Foundation

struct Scrip {
    var id              : Int
    var last            : String?
    var lowestAsk       : String?
    var highestBid      : String?
    var percentChange   : String?
    var baseVolume      : String?
    var quoteVolume     : String?
    var isFrozen        : String?
    var high24hr        : String?
    var low24hr         : String?
    
    func currency()-> String {
        return CurrencyName.shared.currencyNameForID(id:self.id)
    }
}
