//
//  SettingsViewController.swift
//  Roll
//
//  Created by tagline13 on 02/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lbl_setting: UILabel!
    @IBOutlet weak var top_lbl_setting: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_setting: NSLayoutConstraint!
    
    @IBOutlet weak var view_details: UIView!
    @IBOutlet weak var top_view_details: NSLayoutConstraint!
    @IBOutlet weak var leading_view_details: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_details: NSLayoutConstraint!
    
    
    @IBOutlet weak var view_notification: UIView!
    @IBOutlet weak var lbl_pushnotification: UILabel!
    @IBOutlet weak var switch_notification: UISwitch!
    @IBOutlet weak var height_lbl_notification: NSLayoutConstraint!
    @IBOutlet weak var height_view_notification: NSLayoutConstraint!
    
    
    @IBOutlet weak var view_terms: UIView!
    @IBOutlet weak var btn_terms: UIButton!
    @IBOutlet weak var height_view_terms: NSLayoutConstraint!
    @IBOutlet weak var lbl_terms: UILabel!
    @IBOutlet weak var height_lbl_terms: NSLayoutConstraint!
    
    @IBOutlet weak var view_policy: UIView!
    @IBOutlet weak var btn_policy: UIButton!
    @IBOutlet weak var height_view_policy: NSLayoutConstraint!
    @IBOutlet weak var lbl_policy: UILabel!
    @IBOutlet weak var height_lbl_policy: NSLayoutConstraint!
    
    @IBOutlet weak var view_sendgift: UIView!
    @IBOutlet weak var btn_sendgift: UIButton!
    @IBOutlet weak var height_view_sendgift: NSLayoutConstraint!
    @IBOutlet weak var lbl_sendgift: UILabel!
    @IBOutlet weak var height_lbl_sendgift: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        setFont()
        setLayout()
        setData()
    }
    
    //MARK:- Custom Functions
    
    func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = AppColor.clear
//        let BackButton = UIBarButtonItem(image: UIImage(named: "back-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
//        self.navigationItem.leftBarButtonItem  = BackButton
        let button = UIButton.init(type: .custom)
              button.setImage(UIImage.init(named: "back-icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
              button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
              button.layer.borderWidth = 1
              button.layer.cornerRadius = 10
              button.layer.borderColor = AppColor.darkgrayColor.cgColor
              button.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem  =  UIBarButtonItem(customView: button)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setFont(){
        self.lbl_setting.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
         self.lbl_terms.font = AppFont.MuseoSansCyrl_500(fontSize: 22)
         self.lbl_policy.font = AppFont.MuseoSansCyrl_500(fontSize: 22)
         self.lbl_sendgift.font = AppFont.MuseoSansCyrl_500(fontSize: 22)
        self.lbl_pushnotification.font = AppFont.MuseoSansCyrl_500(fontSize: 22)
    }
    
    func setLayout(){
        
        self.top_lbl_setting.constant = UIHelper.setAutoSize(size: 30)
        self.leading_lbl_setting.constant = UIHelper.setAutoSize(size: 30)
        self.top_view_details.constant = UIHelper.setAutoSize(size: 30)
//        self.leading_view_details.constant = UIHelper.setAutoSize(size: 30)
//        self.trailing_view_details.constant = UIHelper.setAutoSize(size: 30)
        
        self.height_view_notification.constant = UIHelper.setAutoSize(size: 80)
        
        self.height_view_terms.constant = UIHelper.setAutoSize(size: 80)
        self.height_lbl_terms.constant = UIHelper.setAutoSize(size: 30)
        
        self.height_view_policy.constant = UIHelper.setAutoSize(size: 80)
        self.height_lbl_policy.constant = UIHelper.setAutoSize(size: 30)
        
        self.height_view_sendgift.constant = UIHelper.setAutoSize(size: 80)
        self.height_lbl_sendgift.constant = UIHelper.setAutoSize(size: 30)
        
      
        
//        self.lbl_pushnotification.textColor = AppColor.blackColor
        
       
    }
    
    func setData(){
        self.lbl_setting.text = AppString.setting
        self.lbl_pushnotification.text = AppString.pushnotification
        self.lbl_terms.text = AppString.terms
        self.lbl_policy.text = AppString.policy
        self.lbl_sendgift.text = AppString.sendgift
        
        
    }
    
    
   
    @IBAction func btn_sendgift_tapped(_ sender: Any) {
    }
    @IBAction func btn_policy_tapped(_ sender: Any) {
    }
    
    @IBAction func btn_terms_tapped(_ sender: Any) {
    }
    @IBAction func switch_notification_tapped(_ sender: Any) {
        if self.switch_notification.isOn == false {
            UIApplication.shared.unregisterForRemoteNotifications()
        }else{
            UIApplication.shared.registerForRemoteNotifications()
        }
        
    }
}
