//
//  CardViewCell.swift
//  Roll
//
//  Created by tagline13 on 23/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    @IBOutlet weak var view_card: UIView!
    @IBOutlet weak var lbl_cardName: UILabel!
    @IBOutlet weak var txt_cardNumber: UITextField!
    @IBOutlet weak var txt_month: UITextField!
    @IBOutlet weak var txt_year: UITextField!
    @IBOutlet weak var txt_cvv: UITextField!
    
    @IBOutlet weak var top_lbl_cardNumber: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_CardNumber: NSLayoutConstraint!
    @IBOutlet weak var leading_txt_cardNumber: NSLayoutConstraint!
    @IBOutlet weak var trailing_txt_cardNumber: NSLayoutConstraint!
    @IBOutlet weak var top_view_bottom: NSLayoutConstraint!
    @IBOutlet weak var leading_view_bottom: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_bottom: NSLayoutConstraint!
    @IBOutlet weak var bottom_view_bottom: NSLayoutConstraint!
    
    @IBOutlet weak var height_txt_cardNumber: NSLayoutConstraint!
    @IBOutlet weak var height_view_bottom: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLayout()
        self.setFont()
    }
    
    func setLayout(){
        self.top_lbl_cardNumber.constant = UIHelper.setAutoSize(size: 31)
        self.leading_lbl_CardNumber.constant = UIHelper.setAutoSize(size: 31)
        self.leading_txt_cardNumber.constant = UIHelper.setAutoSize(size: 31)
        self.trailing_txt_cardNumber.constant = UIHelper.setAutoSize(size: 100)
        self.top_view_bottom.constant = UIHelper.setAutoSize(size: 31)
        self.leading_view_bottom.constant = UIHelper.setAutoSize(size: 31)
        self.trailing_view_bottom.constant = UIHelper.setAutoSize(size: 29)
        self.bottom_view_bottom.constant = UIHelper.setAutoSize(size: 29)
        UIHelper.BottomBorder(globeView: self.txt_cardNumber)
        UIHelper.BottomBorder(globeView: self.txt_cvv)
        UIHelper.BottomBorder(globeView: self.txt_month)
        UIHelper.BottomBorder(globeView: self.txt_year)
    }
    
    func setFont(){
        self.lbl_cardName.font = AppFont.MuseoSansCyrl_700(fontSize: 20)
        
         self.txt_cardNumber.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
         self.txt_month.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
         self.txt_cvv.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.txt_year.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
    }

}
