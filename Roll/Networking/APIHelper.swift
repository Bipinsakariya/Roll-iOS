//
//  APIHelper.swift
//  Roll
//
//  Created by tagline13 on 22/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}



