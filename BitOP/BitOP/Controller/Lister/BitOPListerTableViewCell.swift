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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
