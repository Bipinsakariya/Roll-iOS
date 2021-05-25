//
//  RestaurantsViewCell.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class RestaurantsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var cell_image: UIImageView!
    @IBOutlet weak var cell_bottomView: UIView!
    @IBOutlet weak var cell_name: UILabel!
    @IBOutlet weak var cell_description: UILabel!
    @IBOutlet weak var cell_button: UIButton!
    @IBOutlet weak var height_cell_bottomview: NSLayoutConstraint!
    @IBOutlet weak var leading_cell_name: NSLayoutConstraint!
    @IBOutlet weak var top_cell_name: NSLayoutConstraint!
    @IBOutlet weak var trailing_cell_name: NSLayoutConstraint!
    @IBOutlet weak var leading_cell_description: NSLayoutConstraint!
    @IBOutlet weak var top_cell_description: NSLayoutConstraint!
    @IBOutlet weak var trailing_cell_description: NSLayoutConstraint!
    @IBOutlet weak var trailing_cell_button: NSLayoutConstraint!
    @IBOutlet weak var top_cell_button: NSLayoutConstraint!
    @IBOutlet weak var bottom_cell_button: NSLayoutConstraint!
    @IBOutlet weak var btn_viewmenu: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLayout()
        self.setFont()
        self.setData()
    }
    
    func setLayout(){
        self.top_cell_name.constant = UIHelper.FontSize(size: 16)
        self.leading_cell_name.constant = UIHelper.FontSize(size: 16)
        self.trailing_cell_name.constant = UIHelper.setAutoSize(size: 20)
        self.top_cell_description.constant = UIHelper.FontSize(size: 4)
        self.leading_cell_description.constant = UIHelper.FontSize(size: 16)
        self.trailing_cell_description.constant = UIHelper.setAutoSize(size: 20)
        self.height_cell_bottomview.constant = UIHelper.FontSize(size: 62)
        self.top_cell_button.constant = UIHelper.setAutoSize(size: 15)
        self.bottom_cell_button.constant = UIHelper.setAutoSize(size: 15)
        self.cell_button.layer.backgroundColor = AppColor.blueColor.cgColor
        UIHelper.courner_View(globeView: cell_button, redius: UIHelper.setAutoSize(size: 17))
        UIHelper.courner_View(globeView: btn_viewmenu, redius: UIHelper.setAutoSize(size: 17))
    }
    
    func setFont(){
        self.cell_name.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.cell_description.font = AppFont.MuseoSansCyrl_500(fontSize: 10)
    }
    
    func setData(){
        self.cell_button.setTitle(AppButtons.checkIn, for: .normal)
        self.btn_viewmenu.setTitle(AppButtons.viewmenu, for: .normal)
    }
    
}
