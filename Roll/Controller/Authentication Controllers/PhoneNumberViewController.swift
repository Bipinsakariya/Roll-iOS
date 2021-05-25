//
//  PhoneNumberViewController.swift
//  Roll
//
//  Created by tagline13 on 23/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseCoreDiagnostics


class PhoneNumberViewController: UIViewController {
    
    // MARK: - Outlets and Variables
    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var txt_phonenumber: FPNTextField!
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var lbl_enterphone: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet var top_img_logo: NSLayoutConstraint!
    @IBOutlet weak var height_img_logo: NSLayoutConstraint!
    @IBOutlet weak var top_lbl_enterphone: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_enterphone: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_enterphone: NSLayoutConstraint!
    @IBOutlet weak var tralinig_lbl_description: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_description: NSLayoutConstraint!
    @IBOutlet weak var height_txt_phonenumber: NSLayoutConstraint!
    @IBOutlet weak var leading_txt_phonenumber: NSLayoutConstraint!
    @IBOutlet weak var traling_txt_Phonenumber: NSLayoutConstraint!
    @IBOutlet weak var top_btn_continue: NSLayoutConstraint!
    @IBOutlet weak var leading_btn_continue: NSLayoutConstraint!
    @IBOutlet weak var trailing_btn_continue: NSLayoutConstraint!
    @IBOutlet weak var height_btn_continue: NSLayoutConstraint!
    
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var country_code = "+1"
    
    
    // MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_phonenumber.delegate = self
        self.btn_continue.isEnabled = false
        self.txt_phonenumber.becomeFirstResponder()
        self.country_code = "+ \(CountryHelper.getCountryCode()!)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
        setFont()
        setNavigation()
        setData()
        
        txt_phonenumber.pickerView.showPhoneNumbers = false        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    // MARK: - Custom views
    func setFont(){
        self.lbl_enterphone.font = AppFont.MuseoSansCyrl_500(fontSize: 19)
        self.lbl_description.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
        self.lbl_description.textColor = AppColor.SubTitleColor
        
        self.btn_continue.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 16)
        self.txt_phonenumber.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        
    }
    
    func setLayout(){
//        self.view.translatesAutoresizingMaskIntoConstraints = true
//        self.top_img_logo.constant = UIHelper.setAutoSize(size: 75)
//        self.height_img_logo.constant = UIHelper.setAutoSize(size: 80)
//        self.top_lbl_enterphone.constant = UIHelper.setAutoSize(size: 50)
//        self.leading_lbl_enterphone.constant = UIHelper.setAutoSize(size: 40)
//        self.trailing_lbl_enterphone.constant = UIHelper.setAutoSize(size: 40)
//        self.leading_lbl_description.constant = UIHelper.setAutoSize(size: 40)
//        self.tralinig_lbl_description.constant = UIHelper.setAutoSize(size: 40)
//        self.leading_txt_phonenumber.constant = UIHelper.setAutoSize(size: 40)
//        self.traling_txt_Phonenumber.constant = UIHelper.setAutoSize(size: 40)
//        self.height_txt_phonenumber.constant = UIHelper.setAutoSize(size: 50)
//        self.height_btn_continue.constant = UIHelper.setAutoSize(size: 50)
//        self.top_btn_continue.constant = UIHelper.setAutoSize(size: 20)
//        self.leading_btn_continue.constant = UIHelper.setAutoSize(size: 40)
//        self.trailing_btn_continue.constant = UIHelper.setAutoSize(size: 40)
        UIHelper.shadow_View(globeView: self.btn_continue)
//        UIHelper.courner_View(globeView: self.btn_continue, redius: UIHelper.setAutoSize(size: 15))
        
        UIHelper.courner_View(globeView: self.btn_continue, redius:self.btn_continue.frame.size.height/2)
        self.txt_phonenumber.textAlignment = .center
        UIHelper.BottomBorderWithColor(globeView: self.txt_phonenumber, color: AppColor.SubTitleColor)
        self.txt_phonenumber.setRightPaddingPoints(25)
//        self.txt_phonenumber.rightView.se
    }
    
    func setData(){
        self.btn_continue.setTitle(AppButtons.Continue, for: .normal)
        self.lbl_enterphone.text = AppString.enterPhonenumber
        self.lbl_description.text = AppString.phoneDescription
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Button Tapped Actions
    @IBAction func btn_continue_tapped(_ sender: Any) {
        print("\(self.country_code) \(txt_phonenumber.text!)")
        PhoneAuthProvider.provider().verifyPhoneNumber("\(self.country_code) \(txt_phonenumber.text!)", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                print("_____________")
                print(error.localizedDescription)
                print("_____________")
                return
            }else{
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                let vc = Storyboards.AuthenticationView.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                vc.mobile_no = "\(self.country_code) \(self.txt_phonenumber.text!)"
                
                self.navigationController?.pushViewController(vc, animated: true)
                print("BUTTON TAPPED")
            }
        }
    }
    
}

extension PhoneNumberViewController: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code) // Output "France", "+33", "FR"
        self.country_code = dialCode
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            textField.getFormattedPhoneNumber(format: .E164)
            textField.getRawPhoneNumber()
            self.btn_continue.isEnabled = true
            self.btn_continue.backgroundColor = AppColor.blackColor
            self.btn_continue.alpha = 1.0
            UIHelper.BottomBorderWithColor(globeView: self.txt_phonenumber, color: AppColor.greenColor)
            print("VALID \(textField.text)")
        } else {
            print("NOT VALID")
            self.btn_continue.isEnabled = false
            self.btn_continue.backgroundColor = AppColor.blackColor
            self.btn_continue.alpha = 0.3
            UIHelper.BottomBorderWithColor(globeView: self.txt_phonenumber, color: AppColor.redColor)
        }
    }
}
