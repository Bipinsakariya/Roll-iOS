//
//  OrderHistoryViewCell.swift
//  Roll
//
//  Created by tagline13 on 02/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class OrderHistoryViewCell: UICollectionViewCell {

    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var img_order: UIImageView!
    @IBOutlet weak var top_img_order: NSLayoutConstraint!
    @IBOutlet weak var leading_img_order: NSLayoutConstraint!
    @IBOutlet weak var bottom_img_order: NSLayoutConstraint!
    @IBOutlet weak var view_detail: UIView!
    @IBOutlet weak var top_view_detail: NSLayoutConstraint!
    @IBOutlet weak var leading_view_detail: NSLayoutConstraint!
    @IBOutlet weak var bottom_view_detail: NSLayoutConstraint!
    @IBOutlet weak var lbl_order_name: UILabel!
    @IBOutlet weak var lbl_order_date: UILabel!
    @IBOutlet weak var lbl_order_price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        setLayout()
    }
    
    func setLayout(){
        self.top_img_order.constant = UIHelper.setAutoSize(size: 15)
         self.leading_img_order.constant = UIHelper.setAutoSize(size: 15)
         self.bottom_img_order.constant = UIHelper.setAutoSize(size: 15)
         self.top_view_detail.constant = UIHelper.setAutoSize(size: 15)
         self.leading_view_detail.constant = UIHelper.setAutoSize(size: 15)
         self.bottom_view_detail.constant = UIHelper.setAutoSize(size: 15)
        
        UIHelper.courner_View(globeView: img_order, redius: UIHelper.setAutoSize(size: 20))
    }
    
    func setFont(){
        self.lbl_order_date.font = AppFont.MuseoSansCyrl_500(fontSize: 12)
        self.lbl_order_price.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
        self.lbl_order_name.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
    }

}
