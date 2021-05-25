//
//  AddCardViewCell.swift
//  Roll
//
//  Created by tagline13 on 23/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class AddCardViewCell: UICollectionViewCell {

    @IBOutlet weak var view_card: UIView!
    @IBOutlet weak var lbl_add: UILabel!
    @IBOutlet weak var btn_add: UIButton!
    @IBOutlet weak var top_lbl_add: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_add: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_add: NSLayoutConstraint!
    
    
    @IBOutlet weak var height_btn_add: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        setLayout()
        setData()
    }
    
    func setFont(){
        lbl_add.font = AppFont.MuseoSansCyrl_700(fontSize: 10)
    }
    
    func setLayout(){
        self.top_lbl_add.constant = UIHelper.setAutoSize(size: 25)
        self.leading_lbl_add.constant = UIHelper.setAutoSize(size: 25)
        self.trailing_lbl_add.constant = UIHelper.setAutoSize(size: 25)
        self.height_btn_add.constant = UIHelper.setAutoSize(size: 44)
        view_card.backgroundColor = AppColor.darkgrayColor
        UIHelper.courner_View(globeView: view_card, redius: 14)
        
        
        UIHelper.courner_View(globeView: self.btn_add, redius: UIHelper.setAutoSize(size: 22))
    }
    
    func setData(){
        self.lbl_add.text = AppString.addCard
    }
    
    
    

}
