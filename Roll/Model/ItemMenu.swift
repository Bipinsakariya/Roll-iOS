//
//  ItemMenu.swift
//  Roll
//
//  Created by tagline13 on 09/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
class ItemMenu: NSObject {
    
    static var shared = ItemMenu()
    
    var name: String?
    var notes : String?
    var price : Int?
    var amount : Int?
}
