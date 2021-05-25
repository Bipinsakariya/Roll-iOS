//
//  OrderConstants.swift
//  Roll
//
//  Created by tagline13 on 01/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation

struct AppOrderKeys {
   static var restaurantId = "restaurantId"
   static var businessName = "businessName"
   static var createdAt = "createdAt"
   static var grandTotal = "grandTotal"
   static var promoCode = "promoCode"
   static var status = "status"
   static var subTotal = "subTotal"
   static var tableNumber = "tableNumber"
   static var taxAmount = "taxAmount"
   static var updatedAt = "updatedAt"
   static var userId = "userId"
   static var items = "items"
   static var server = "server"
    
    static func sendOrderDetails(restaurantId : String , businessName : String , createdAt : String , grandTotal : Int , promoCode : Int , status : String  , subTotal : Int , tableNumber : Int , taxAmount : Int , updatedAt : String  , userId : String , items : NSArray , server : NSArray ) -> [String : Any ]{
        return [
            AppOrderKeys.restaurantId : restaurantId,
            AppOrderKeys.businessName : businessName,
            AppOrderKeys.createdAt : createdAt,
            AppOrderKeys.grandTotal : grandTotal,
            AppOrderKeys.promoCode : promoCode,
            AppOrderKeys.status : status,
            AppOrderKeys.subTotal : subTotal,
            AppOrderKeys.tableNumber : tableNumber,
            AppOrderKeys.taxAmount : taxAmount,
            AppOrderKeys.updatedAt : updatedAt,
            AppOrderKeys.userId : userId,
            AppOrderKeys.items : items,
            AppOrderKeys.server : server,
        ]
        
    }
}
