//
//  OrderDetail.swift
//  Roll
//
//  Created by tagline13 on 09/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
class OrderDetails: NSObject {
    
    static var shared = OrderDetails()
    
    var restaurantId: String?
    var businessName : String?
    var createdAt : String?
    var grandTotal : Any?
    var promoCode : Any?
    var status : String?
    var subTotal : Any?
    var tableNumber: Any?
    var taxAmount : Any?
    var updatedAt: String?
    var userId : String?
    var items : NSArray?
    var server : NSArray?
}

