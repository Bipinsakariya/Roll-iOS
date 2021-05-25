//
//  JustarrivedViewController.swift
//  Roll
//
//  Created by tagline13 on 07/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import Presentr
import FirebaseFirestore



class JustarrivedViewController: UIViewController {
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
        
        
        @IBOutlet weak var btn_readyForLeave: UIButton!
        @IBOutlet weak var top_btn_readyForLeave: NSLayoutConstraint!
        @IBOutlet weak var trailing_btn_readyForLeave: NSLayoutConstraint!
        @IBOutlet weak var bottom_btn_readyForLeave: NSLayoutConstraint!
        
        @IBOutlet weak var btn_viewMenu: UIButton!
        @IBOutlet weak var leading_viewMenu: NSLayoutConstraint!
        @IBOutlet weak var trailing_view_Menu: NSLayoutConstraint!
        @IBOutlet weak var btn_checkout: UIButton!
        @IBOutlet weak var trailing_btn_checkout: NSLayoutConstraint!
        
        var Restorunt_Detail = RestaurantsData()
        var db = Firestore.firestore()
        var orderID : String?
        var menuLink : String?
        
        let presenter1: Presentr = {
            let width = ModalSize.full
            let height = ModalSize.default
            let customType = PresentationType.custom(width: width, height: height, center: .bottomCenter)
            let customPresenter = Presentr(presentationType : customType)
            customPresenter.roundCorners = true
            customPresenter.backgroundOpacity = 0.0
            customPresenter.cornerRadius = 50
            
            return customPresenter
        }()
        
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
            self.top_btn_readyForLeave.constant = UIHelper.setAutoSize(size: 20)
            self.trailing_btn_readyForLeave.constant = UIHelper.setAutoSize(size: 55)
            self.leading_viewMenu.constant = UIHelper.setAutoSize(size: 30)
            //        self.bottom_btn_viewMenu.constant = UIHelper.setAutoSize(size: 31)
            self.trailing_view_Menu.constant = UIHelper.setAutoSize(size: 22)
            self.bottom_btn_readyForLeave.constant = UIHelper.setAutoSize(size: 9)
            self.trailing_btn_checkout.constant = UIHelper.setAutoSize(size: 30)
            //        self.bottom_btn_checkout.constant = UIHelper.setAutoSize(size: 34)
            
            
            self.btn_readyForLeave.tintColor = AppColor.blueColor
            self.btn_viewMenu.tintColor = AppColor.whiteColor
            self.btn_checkout.tintColor = AppColor.whiteColor
            self.btn_viewMenu.layer.backgroundColor = AppColor.blueColor.cgColor
            self.btn_checkout.layer.backgroundColor = AppColor.blackColor.cgColor
            
            UIHelper.courner_View(globeView: btn_viewMenu, redius: UIHelper.setAutoSize(size: 15))
            UIHelper.courner_View(globeView: btn_checkout, redius: UIHelper.setAutoSize(size: 20))
        }
        
        func setFont(){
            self.lbl_name.font = AppFont.MuseoSansCyrl_700(fontSize: 25)
            self.lbl_status.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
            self.btn_readyForLeave.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 15)
            self.btn_viewMenu.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
            self.btn_checkout.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
        }
        
        func setData(){
            self.lbl_name.text = "Joyce Garden"
            self.lbl_status.text = "You’re just arrived!"
            self.btn_readyForLeave.setTitle(AppButtons.readyForLeave, for: .normal)
            self.btn_viewMenu.setTitle(AppButtons.viewmenu, for: .normal)
            self.btn_checkout.setTitle(AppButtons.checkout, for: .normal)
            
            let fullString = NSMutableAttributedString(string: "Please let your server know you've checked into ")
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "roll_logo 4")
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            fullString.append(NSAttributedString(string: " under “DHILLON”"))
            self.lbl_description.attributedText = fullString
            
        }
        
        //MARK:- IBActions for buttons
        @IBAction func btn_readyForLeave_tapped(_ sender: Any) {
        }
        
        @IBAction func btn_viewMenu_tapped(_ sender: Any) {
            let vc = Storyboards.DiningView.instantiateViewController(identifier: "ViewMenuController") as! ViewMenuController
                  
            vc.menulink = self.menuLink
            if self.menuLink! == ""{
                
            }else{
                customPresentViewController(presenter1, viewController: vc, animated: true, completion: nil)
            }
            
        }
        
        @IBAction func btn_checkOut_tapped(_ sender: Any) {
            do {
                let docId = self.orderID!
                print(self.orderID!)
                do {
                    try self.db.collection(AppFirebaseKey.orders).document(docId).updateData(["\(AppOrderKeys.status)" : "\(AppOrderStatusKeys.checkmeout)"], completion: { (error) in
                        print("++++++++++++++++")
                        print("ERROR : \(error)")
                        print("++++++++++++++++")
                    })
                } catch let error {
                    print("Error writing city to Firestore: \(error)")
                }
                
    
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
            
            
        }
    }
