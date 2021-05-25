//
//  OTPViewController.swift
//  Roll
//
//  Created by tagline13 on 23/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import OTPFieldView
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseCoreDiagnostics
import FirebaseFirestoreSwift
import SwiftSpinner


class OTPViewController: UIViewController {
    
    
    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var view_otp: OTPFieldView!
    @IBOutlet weak var btn_resend: UIButton!
    @IBOutlet weak var lbl_enterotp: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
    @IBOutlet var top_img_logo: NSLayoutConstraint!
    @IBOutlet weak var height_img_logo: NSLayoutConstraint!
    @IBOutlet weak var top_lbl_enterotp: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_enterotp: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_enterotp: NSLayoutConstraint!
    @IBOutlet weak var tralinig_lbl_description: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_description: NSLayoutConstraint!
    @IBOutlet weak var height_view_otp: NSLayoutConstraint!
    @IBOutlet weak var leading_view_otp: NSLayoutConstraint!
    @IBOutlet weak var traling_view_otp: NSLayoutConstraint!
    @IBOutlet weak var top_btn_resend: NSLayoutConstraint!
    @IBOutlet weak var width_btn_resend: NSLayoutConstraint!
    
    
    
    var mobile_no : String?
    var OtpEnterdvalue : String?
    var code : String?
    var db = Firestore.firestore()
    var isProfileAdded : Bool?
    var UsersList = Array<QueryDocumentSnapshot>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setData()
        setNavigation()
        setFont()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupOtpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    // MARK: - Custom views
    
    func setFont(){
        self.lbl_enterotp.font = AppFont.MuseoSansCyrl_700(fontSize: 19)
        self.lbl_description.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
        self.btn_resend.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 14)
        
        self.btn_resend.setTitle(AppButtons.resend, for: .normal)
    }
    
    func setLayout(){
//        self.top_img_logo.constant = UIHelper.setAutoSize(size: 75)
//        self.height_img_logo.constant = UIHelper.setAutoSize(size: 80)
//        self.top_lbl_enterotp.constant = UIHelper.setAutoSize(size: 50)
//        self.leading_lbl_enterotp.constant = UIHelper.setAutoSize(size: 40)
//        self.trailing_lbl_enterotp.constant = UIHelper.setAutoSize(size: 40)
//        self.leading_lbl_description.constant = UIHelper.setAutoSize(size: 40)
//        self.tralinig_lbl_description.constant = UIHelper.setAutoSize(size: 40)
//        self.leading_view_otp.constant = UIHelper.setAutoSize(size: 15)
//        self.traling_view_otp.constant = UIHelper.setAutoSize(size: 15)
//        self.height_view_otp.constant = UIHelper.setAutoSize(size: 50)
//        self.width_btn_resend.constant = UIHelper.setAutoSize(size: 200)
//        self.top_btn_resend.constant = UIHelper.setAutoSize(size: 20)
        
        self.btn_resend.titleLabel?.textColor = AppColor.blueColor
    }
    
    func setData(){
        self.lbl_description.text = "Text send to \(mobile_no!)"
        self.btn_resend.setTitle(AppButtons.resend, for: .normal)
        self.lbl_enterotp.text = AppString.enterOtp
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupOtpView(){
        self.view_otp.fieldsCount = 6
        self.view_otp.fieldBorderWidth = 4
        self.view_otp.defaultBorderColor = AppColor.redColor
        self.view_otp.filledBorderColor = AppColor.greenColor
        self.view_otp.cursorColor = UIColor.red
        self.view_otp.displayType = .underlinedBottom
        self.view_otp.fieldSize = UIHelper.setAutoSize(size: 40)
        self.view_otp.separatorSpace = UIHelper.setAutoSize(size: 15)
        self.view_otp.shouldAllowIntermediateEditing = true
        self.view_otp.shouldAllowIntermediateEditing = false
        self.view_otp.delegate = self
        self.view_otp.initializeUI()
        
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Button Tapped Actions
    @IBAction func btn_resend_tapped(_ sender: Any) {
        print("BUTTON TAPPED")
        PhoneAuthProvider.provider().verifyPhoneNumber("\(self.mobile_no!)", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                print("_____________")
                print(error.localizedDescription)
                print("_____________")
                return
            }else{
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
        }
    }
    
    func VerifyOTP() {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: self.OtpEnterdvalue!)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                if ( authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
                    let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in (resolver.hints) {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }
                    self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
                        var selectedHint: PhoneMultiFactorInfo?
                        for tmpFactorInfo in resolver.hints {
                            if (displayName == tmpFactorInfo.displayName) {
                                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                            }
                        }
                        PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
                            if error != nil {
                                print("Multi factor start sign in failed. Error: \(error.debugDescription)")
                            } else {
                                self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
                                        if error != nil {
                                            print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
                                        } else {
                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                })
                            }
                        }
                    })
                } else {
                    SwiftSpinner.show("Connecting to tabz...").addTapHandler({
                        SwiftSpinner.hide()
                    }, subtitle: error.localizedDescription)
                    return
                }
                return
            }
            else{
                SwiftSpinner.show("Connecting to tabz...")
                UserHelper.saveUserIDInUserDefaults(id: Auth.auth().currentUser!.uid)
                let currentUSer =  Auth.auth().currentUser
                currentUSer?.getIDToken(completion: { (result, error) in
                    print(result)
                    if let error = error {
                        print("Error : \(error)")
                    }else{
                        UserHelper.saveUserAccessTokenInUserDefaults(token: result!)
                    }
                    
                })
                self.readArray()
            }
        }
    }
    
    func readArray() {
        self.db.collection(AppFirebaseKey.users)
            .getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    SwiftSpinner.hide()
                    for i in snapshot!.documents {
                        let docID = i.documentID
                        
                        self.UsersList.append(i)
                    }
                    let filterByLocation = self.UsersList.filter() { $0.documentID == UserHelper.getUserIDFromUserDefaults() }
                    print(filterByLocation.count)
                    if filterByLocation.count != 0 {
                        do {
                            try self.db.collection(AppFirebaseKey.users).document( UserHelper.getUserIDFromUserDefaults()).updateData([AppUserKey.DeviceToken : UserHelper.getFCMFromUserDefaults()])

                        } catch let error {
                            print("Error writing city to Firestore: \(error)")
                        }
                        for item in filterByLocation{
                            if item.documentID == UserHelper.getUserIDFromUserDefaults(){
                                UserHelper.saveUserDetail(Details: item.data() as NSDictionary? ?? [:] as NSDictionary)
                            }
                        }
                        let vc = Storyboards.DiningView.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)

                    }else{
                        let vc = Storyboards.AuthenticationView.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    
                    for item in filterByLocation{
                        print(item)
                    }
                }
        }
    }
    
    
}

extension OTPViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if hasEntered == true {
            VerifyOTP()
        }
        return false
        
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.OtpEnterdvalue = otpString
    }
}

