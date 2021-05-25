//
//  OrderItemListViewCell.swift
//  Roll
//
//  Created by tagline13 on 28/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class OrderItemListViewCell: UICollectionViewCell {

     @IBOutlet weak var view_main: UIView!
      @IBOutlet weak var img_menu: UIImageView!
      @IBOutlet weak var lbl_name: UILabel!
      @IBOutlet weak var lbl_price: UILabel!
      
      override func awakeFromNib() {
          super.awakeFromNib()
      }
}
