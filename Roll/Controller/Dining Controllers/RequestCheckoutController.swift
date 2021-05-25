//
//  RequestCheckoutController.swift
//  Roll
//
//  Created by tagline13 on 28/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import Presentr

class RequestCheckoutController: UIViewController {
    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var top_lbl_name: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_name: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_name: NSLayoutConstraint!
    
    @IBOutlet weak var img_checkmark: UIImageView!
    @IBOutlet weak var top_img_checkmark: NSLayoutConstraint!
    @IBOutlet weak var height_img_checkmark: NSLayoutConstraint!
    
    
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var top_lbl_status: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_status: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_status: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var top_lbl_description: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_description: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_description: NSLayoutConstraint!
    
    
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var top_btn_cancel: NSLayoutConstraint!
    @IBOutlet weak var leading_btn_cancel: NSLayoutConstraint!
    @IBOutlet weak var trailing_btn_cancel: NSLayoutConstraint!
    @IBOutlet weak var bottom_btn_cancel: NSLayoutConstraint!
    @IBOutlet weak var height_btn_cancel: NSLayoutConstraint!
    
   
    
    
    let presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.full
        let customType = PresentationType.custom(width: width, height: height, center: .bottomCenter)
        let customPresenter = Presentr(presentationType : customType)
        customPresenter.roundCorners = true
        customPresenter.backgroundOpacity = 0.3
        customPresenter.cornerRadius = 50
        
        return customPresenter
    }()
    var orderID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLayout()
        self.setData()
        self.setFont()
    }
    
    //MARK:- Custom layout functions
    
    
    
    func setLayout(){
        self.top_lbl_name.constant = UIHelper.setAutoSize(size: 50)
        self.leading_lbl_name.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_lbl_name.constant = UIHelper.setAutoSize(size: 30)
        self.top_img_checkmark.constant = UIHelper.setAutoSize(size: 27)
        self.height_img_checkmark.constant = UIHelper.setAutoSize(size: 40)
        self.top_lbl_status.constant = UIHelper.setAutoSize(size: 22)
        self.leading_lbl_status.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_lbl_status.constant = UIHelper.setAutoSize(size: 30)
        self.top_lbl_description.constant = UIHelper.setAutoSize(size: 30)
        self.leading_lbl_description.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_lbl_description.constant = UIHelper.setAutoSize(size: 30)
        self.bottom_btn_cancel.constant = UIHelper.setAutoSize(size: 9)
        self.trailing_btn_cancel.constant = UIHelper.setAutoSize(size: 30)
        self.bottom_btn_cancel.constant = UIHelper.setAutoSize(size: 30)
        self.height_btn_cancel.constant = UIHelper.setAutoSize(size: 50)
        
        self.btn_cancel.layer.backgroundColor = AppColor.blackColor.cgColor
         UIHelper.courner_View(globeView: btn_cancel, redius: UIHelper.setAutoSize(size: 20))
    }
    
    func setFont(){
        self.lbl_name.font = AppFont.MuseoSansCyrl_700(fontSize: 25)
        self.lbl_status.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.btn_cancel.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
    }
    
    func setData(){
        self.lbl_name.text = "Joyce Garden"
        self.lbl_status.text = "You’re Checked In!"
        self.btn_cancel.setTitle(AppButtons.checkout, for: .normal)
        
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: "Please let your server know you've checked into ")

        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: "roll_logo 4")
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: " under “DHILLON”"))
        self.lbl_description.attributedText = fullString
        
    }
    
    //MARK:- IBActions for buttons

    @IBAction func btn_cancel_tapped(_ sender: Any) {
        let vc = Storyboards.DiningView.instantiateViewController(identifier:  "CheckoutViewController") as! CheckoutViewController
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
}
