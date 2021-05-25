//
//  RestaurantsData.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation

class RestaurantsData: NSObject {
    
    static var shared = RestaurantsData()
    
    var restaurantId: String?
    var businessName : String?
    var ownerId : String?
    var address : String?
    var state : String?
    var zipCode : String?
    var businessPhone : String?
    var category : String?
    var taxRate : Int?
    var capacity : Int?
    var numberOfEmployees : Int?
    var menuLink : String?
    var businessPhotoUrl : String?
    var businessDescription : String?
    var tipStructure : String?
    var percentOfTipsToHouse : Int?
    var tipAlwaysIncluded : Bool?
    var orderChannel : String?
    var squareRestaurantId : String?
    var servers : NSMutableArray?
    var age : Int?
    var password : String?
    var percentOfTipsHouse : Int?
    var systemBusinessName : String?
    var tipsAlwaysIncluded :   Bool?
    var visitors : NSMutableArray?
    var latitude : Double?
    var longitude : Double?
    var radius : Int?
}

/*
 "restaurantId": "",
 "businessName": "",
 "ownerId": "userId",
 "businessAddress": "",
 "state": "",
 "zipCode": "",
 "businessPhone": "",
 "category": "",
 "taxRate": "",
 "restaurantCapacity": "",
 "numberOfEmployees": 0,
 "menuLink": "",
 "businessPhotoUrl": "",
 "servers": [
 {
 "firstName": "",
 "lastName": "",
 "profilePictureUrl": ""
 }
 ],
 "businessDescription": "",
 "tipStructure": "allToServer" | "equalSplitToServers" | "percentOfTipsToHouse",
 "percentOfTipsToHouse": 0, // only needed if tipStructure is "percentOfTipsToHouse"
 "tipAlwaysIncluded": false,
 "orderChannel": "online-platform" | "tablet",
 "squareRestaurantId": ""
 */
