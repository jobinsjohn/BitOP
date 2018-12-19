//
//  UiApplication+Extensions.swift
//  BitOP
//
//  Created by Jobins John on 12/19/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
