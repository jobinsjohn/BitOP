//
//  Connectivity.swift
//  BitOP
//
//  Created by Jobins John on 12/19/18.
//  Copyright © 2018 Jobins John. All rights reserved.
//

import Foundation

import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
