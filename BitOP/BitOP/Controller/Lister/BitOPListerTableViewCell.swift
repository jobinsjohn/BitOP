//
//  BitOPListerTableViewCell.swift
//  BitOP
//
//  Created by Jobins John on 12/17/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import UIKit

class BitOPListerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currNameLblOutlet: UILabel!
    
    @IBOutlet weak var priceLblOutlet: UILabel!
    
    @IBOutlet weak var volumeTradedLblOutlet: UILabel!
    
    @IBOutlet weak var changePerLblOutlet: UILabel!
    
    @IBOutlet weak var traderRateImgViewOutlet: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        debugPrint("Stock View Table loaded")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with scrip:CurrencyModel,  numberToCompare number:Double?, colorTheme:BitOPColorTheme?){
        self.backgroundColor = colorTheme?.backgroundColor
        
        currNameLblOutlet.text = scrip.currency()
        currNameLblOutlet.textColor = colorTheme?.foregroundColor
        
        priceLblOutlet.text = scrip.lastTradePrice
        priceLblOutlet.textColor = colorTheme?.foregroundColor
        
        changePerLblOutlet.text = scrip.percentChange
        changePerLblOutlet.textColor = colorTheme?.foregroundColor
        

        volumeTradedLblOutlet.text = scrip.quoteVolume
        volumeTradedLblOutlet.textColor = colorTheme?.foregroundColor
        if let anumber = number {
            if Double(scrip.lastTradePrice!) ?? 0 < anumber {
                traderRateImgViewOutlet.image = UIImage(named: "ScripRateDown")
            }else if Double(scrip.lastTradePrice!) ?? 0 > anumber {
                traderRateImgViewOutlet.image = UIImage(named: "ScripRateUp")
            }else{
                traderRateImgViewOutlet.image = nil
            }
        }else {
            traderRateImgViewOutlet.image = nil
        }
    }

}
