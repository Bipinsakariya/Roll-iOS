//
//  FavouriteViewCell.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class FavouriteViewCell: UICollectionViewCell {

    @IBOutlet weak var celll_view: UIView!
    @IBOutlet weak var cell_image: UIImageView!
    @IBOutlet weak var cell_bottomView: UIView!
    @IBOutlet weak var cell_name: UILabel!
    @IBOutlet weak var height_view_bottom: NSLayoutConstraint!
    
     override func awakeFromNib() {
           super.awakeFromNib()
           self.setLayout()
           self.setFont()
       }
       
       func setLayout(){
           self.height_view_bottom.constant = UIHelper.setAutoSize(size: 36)
       }
       
       func setFont(){
           self.cell_name.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
       }
}
