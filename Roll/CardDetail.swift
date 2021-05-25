//
//  CardDetail.swift
//  Roll
//
//  Created by tagline13 on 22/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import UIKit

class CardDetail: NSObject {
    
    static var shared = CardDetail()
    
    var id: String?
    var name : String?
    var object : String?
    var last4 : String?
    var exp_year : String?
    var exp_month : String?
    var brand : String?
    
    var cvc : String?
    var number : String?
}
