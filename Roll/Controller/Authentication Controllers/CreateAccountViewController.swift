//
//  CreateAccountViewController.swift
//  Roll
//
//  Created by tagline13 on 23/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import Presentr
import FittedSheets
import UPCarouselFlowLayout
import TweeTextField
import SwiftSpinner

class CreateAccountViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , PassCardDelegate {
    
    
    @IBOutlet var view_datePicker: UIView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var lbl_createAccount: UILabel!
    @IBOutlet weak var view_name: UIStackView!
    @IBOutlet weak var lbl_firstName: UILabel!
    @IBOutlet weak var txt_firstName: TweeAttributedTextField!
    @IBOutlet weak var lbl_lastName: UILabel!
    @IBOutlet weak var txt_lastName: TweeAttributedTextField!
    @IBOutlet weak var viiew_age: UIView!
    @IBOutlet weak var lbl_age: UILabel!
    @IBOutlet weak var txt_age: TweeAttributedTextField!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_addPayment: UILabel!
    @IBOutlet weak var txt_email: TweeAttributedTextField!
    @IBOutlet weak var collection_paymentsCards: UICollectionView!
    @IBOutlet weak var btn_createAccount: UIButton!
    
    @IBOutlet weak var top_lbl_createAccount: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_createAccount: NSLayoutConstraint!
    @IBOutlet weak var traliing_lbl_createAccount: NSLayoutConstraint!
    @IBOutlet weak var top_view_name: NSLayoutConstraint!
    @IBOutlet weak var leading_view_name: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_name: NSLayoutConstraint!
    @IBOutlet weak var height_view_name: NSLayoutConstraint!
    @IBOutlet weak var top_view_age: NSLayoutConstraint!
    @IBOutlet weak var leading_view_age: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_age: NSLayoutConstraint!
    @IBOutlet weak var height_view_age: NSLayoutConstraint!
    @IBOutlet weak var top_view_email: NSLayoutConstraint!
    @IBOutlet weak var leading_view_email: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_email: NSLayoutConstraint!
    @IBOutlet weak var height_view_email: NSLayoutConstraint!
    
    @IBOutlet weak var top_lbl_payment: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_payment: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_payment: NSLayoutConstraint!
    @IBOutlet weak var height_collectionPayment: NSLayoutConstraint!
    
    @IBOutlet weak var top_btn_createAccount: NSLayoutConstraint!
    @IBOutlet weak var leading_btn_createAccount: NSLayoutConstraint!
    @IBOutlet weak var trailing_btn_createAccount: NSLayoutConstraint!
    @IBOutlet weak var height_btn_account: NSLayoutConstraint!
    
    @IBOutlet weak var txt_year: TweeAttributedTextField!
    @IBOutlet weak var txt_day: TweeAttributedTextField!
    
    var isEditMode : Bool? = nil
    var db = Firestore.firestore()
    var CardData = NSMutableArray()
    var CardDataLocal = NSMutableArray()
    var isAddLocalCard : Bool? = nil
    var theDate = String()
    // MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateCardViewController.delegate = self
        txt_email.placeholderInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
        setFont()
        setData()
        setNavigation()
        setDatePicker()
        let nib = UINib(nibName: "CardViewCell", bundle: nil)
        collection_paymentsCards.register(nib, forCellWithReuseIdentifier: "CardViewCell")
        
        let nib1 = UINib(nibName: "AddCardViewCell", bundle: nil)
        collection_paymentsCards.register(nib1, forCellWithReuseIdentifier: "AddCardViewCell")
        
        if self.isEditMode == true {
            getCardDetails()
            self.btn_createAccount.isHidden = false
            self.isEditingData()
        }
        
        if self.CardDataLocal.count == 0 {
            if self.isEditMode == true {
                self.btn_createAccount.isHidden = false
            }else{
                self.btn_createAccount.isHidden = true
            }
            
        }else{
            self.btn_createAccount.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func GetCard(Data: NSMutableDictionary) {
        
        
        if self.isEditMode == true {
            self.addCard()
            getCardDetails()
            self.btn_createAccount.isHidden = false
        }else{
            self.CardDataLocal.add(Data)
            self.isAddLocalCard = true
            if self.CardDataLocal.count == 0 {
                self.btn_createAccount.isHidden = true
            }else{
                self.btn_createAccount.isHidden = false
            }
        }
        
        self.collection_paymentsCards.reloadData()
    }
    
    // MARK: - Custom views
    func setFont(){
        self.lbl_createAccount.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
        self.lbl_firstName.font = AppFont.MuseoSansCyrl_700(fontSize: 13)
        self.lbl_lastName.font = AppFont.MuseoSansCyrl_700(fontSize: 13)
        self.lbl_age.font = AppFont.MuseoSansCyrl_700(fontSize: 13)
        self.lbl_email.font = AppFont.MuseoSansCyrl_700(fontSize: 13)
        self.lbl_addPayment.font = AppFont.MuseoSansCyrl_700(fontSize: 13)
        self.btn_createAccount.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 24)
        self.txt_age.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.txt_day.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.txt_year.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.txt_email.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.txt_lastName.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.txt_firstName.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.btn_createAccount.setTitle(AppButtons.createAccount, for: .normal)
    }
    
    func setLayout(){
        self.top_lbl_createAccount.constant = UIHelper.setAutoSize(size: 15)
        self.leading_lbl_createAccount.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_btn_createAccount.constant = UIHelper.setAutoSize(size: 30)
        self.leading_view_name.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_view_name.constant = UIHelper.setAutoSize(size: 30)
        self.leading_view_age.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_view_age.constant = UIHelper.setAutoSize(size: 30)
        self.leading_view_email.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_view_email.constant = UIHelper.setAutoSize(size: 30)
        self.leading_lbl_payment.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_lbl_payment.constant = UIHelper.setAutoSize(size: 30)
        self.leading_btn_createAccount.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_btn_createAccount.constant = UIHelper.setAutoSize(size: 30)
        self.top_view_name.constant = UIHelper.setAutoSize(size: 49)
        self.top_view_age.constant = UIHelper.setAutoSize(size: 35)
        self.top_view_email.constant = UIHelper.setAutoSize(size: 35)
        self.top_lbl_payment.constant = UIHelper.setAutoSize(size: 35)
        self.top_btn_createAccount.constant = UIHelper.setAutoSize(size: 35)
        self.height_view_age.constant = UIHelper.setAutoSize(size: 70)
        self.height_view_name.constant = UIHelper.setAutoSize(size: 70)
        self.height_view_email.constant = UIHelper.setAutoSize(size: 70)
        self.height_collectionPayment.constant = UIHelper.setAutoSize(size: 240)
        self.height_btn_account.constant = UIHelper.setAutoSize(size: 50)
        self.txt_age.textColor = AppColor.blackColor
        self.txt_email.textColor = AppColor.blackColor
        self.txt_lastName.textColor = AppColor.blackColor
        self.txt_firstName.textColor = AppColor.blackColor
        UIHelper.shadow_View(globeView: self.btn_createAccount)
        UIHelper.courner_View(globeView: self.btn_createAccount, redius: 15)
    }
    
    func setDatePicker(){
        txt_age.inputAccessoryView = UIView()
        txt_age.inputView = view_datePicker
        
//        txt_day.inputAccessoryView = UIView()
//        txt_day.inputView = view_datePicker
//
//        txt_year.inputAccessoryView = UIView()
//        txt_year.inputView = view_datePicker

        datepicker.maximumDate = Date()
    }
    
    func setData(){
        self.lbl_createAccount.text = AppString.createAcount
        self.txt_firstName.placeholder = AppPlaceHolders.firstName
        self.txt_lastName.placeholder = AppPlaceHolders.lastName
        self.txt_email.placeholder = AppPlaceHolders.email
        self.btn_createAccount.setTitle(AppButtons.createAccount, for: .normal)
        self.lbl_age.text = AppString.age
        self.lbl_firstName.text = AppString.firstName
        self.lbl_lastName.text = AppString.lastName
        self.lbl_email.text = AppString.email
        self.lbl_addPayment.text = AppString.addPaymentMethod
    }
    
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
    
    
    func isEditingData(){
        let userDetails = UserHelper.getUserDetails()
        self.lbl_createAccount.text = AppString.editAccount
        self.txt_firstName.text = (userDetails.value(forKey: AppUserKey.firstName) as! String)
        self.txt_lastName.text = (userDetails.value(forKey: AppUserKey.lastName) as! String)
        self.txt_age.text = (userDetails.value(forKey: AppUserKey.age) as! String)
        self.txt_email.text = (userDetails.value(forKey: AppUserKey.email) as! String)
        self.btn_createAccount.setTitle(AppButtons.save, for: .normal)
        
//         let input = (userDetails.value(forKey: AppUserKey.age) as! String)
//
//        let dateFormatter = DateFormatter()
//        let date = dateFormatter.date(from:input)
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "yyyy"
//        let dateString = formatter.string(from: date!)
//
//            print(dateString)
//            self.txt_year.text = dateString
//
        
        let fullDate    = userDetails.value(forKey: AppUserKey.age) as! String
        let fullDateArr = fullDate.components(separatedBy: " ")
        print(fullDate , fullDateArr)
        self.txt_age.text = fullDateArr[0]
        self.txt_day.text = fullDateArr[1]
        self.txt_year.text = fullDateArr[2]
    }
    
    
    //MARK:- Custom button Actions
    
    @IBAction func btn_age_Tapped(_ sender: Any) {
        txt_age.becomeFirstResponder()
        print("1")
    }
    
    @IBAction func Btn_OK_Tapped(_ sender: Any) {
        txt_age.resignFirstResponder()
        txt_day.resignFirstResponder()
        txt_year.resignFirstResponder()
        let theDateFormate = DateFormatter()
        let theFormatterDate = DateFormatter()
        let daytheFormatterDate = DateFormatter()
        let yeartheFormatterDate = DateFormatter()
        theDateFormate.dateFormat = "MMM dd yyyy"
        theFormatterDate.dateFormat = "MMM"
        daytheFormatterDate.dateFormat = "dd"
        yeartheFormatterDate.dateFormat = "yyyy"
        let theDate = theFormatterDate.string(from: self.datepicker.date)
        let theday = daytheFormatterDate.string(from: self.datepicker.date)
        let theyear = yeartheFormatterDate.string(from: self.datepicker.date)
        print(theDate ,theday , theyear )
        self.txt_age.text = theDate
        self.txt_day.text = theday
        self.txt_year.text = theyear
        txt_age.lineColor = AppColor.greenColor
        txt_day.lineColor = AppColor.greenColor
        txt_year.lineColor = AppColor.greenColor
        
        self.theDate = theDateFormate.string(from: self.datepicker.date)
    }
    
    @IBAction func Btn_CANCEL_Tapped(_ sender: Any) {
        txt_age.resignFirstResponder()
        txt_day.resignFirstResponder()
        txt_year.resignFirstResponder()
    }
    
    @IBAction func btn_createAccount_Tapped(_ sender: Any) {
        if self.isEditMode == true {
            let user :[String : Any] = [AppUserKey.userId: UserHelper.getUserIDFromUserDefaults(), AppUserKey.firstName: self.txt_firstName.text!, AppUserKey.lastName: self.txt_lastName.text!, AppUserKey.squareCustomerId: "", AppUserKey.email: self.txt_email.text!, AppUserKey.age: self.theDate , ]
            self.db.collection(AppFirebaseKey.users).document( UserHelper.getUserIDFromUserDefaults()).updateData(user)
            SwiftSpinner.show("Update your profile")
            let seconds = 10.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.db.collection(AppFirebaseKey.users)
                    .addSnapshotListener { documentSnapshot, error in
                        guard let document = documentSnapshot else {
                            print("Error fetching document: \(error!)")
                            return
                        }
                        for i in documentSnapshot!.documents {
                            if i.documentID == UserHelper.getUserIDFromUserDefaults() {
                                let data_result = i.data() as NSDictionary
                                let user_details = data_result
                                UserHelper.saveUserDetail(Details: data_result)
                                
                            }
                        }
                        SwiftSpinner.hide()
                }
            }
        }
        else{
            let user :[String : Any] = [AppUserKey.userId: UserHelper.getUserIDFromUserDefaults(), AppUserKey.firstName: self.txt_firstName.text!, AppUserKey.lastName: self.txt_lastName.text!, AppUserKey.squareCustomerId: "", AppUserKey.email: self.txt_email.text!, AppUserKey.age: self.theDate, AppUserKey.profilePictureUrl: "" , AppUserKey.DeviceToken: UserHelper.getFCMFromUserDefaults() , AppUserKey.userType: "user", AppUserKey.phone: Auth.auth().currentUser?.phoneNumber as Any , AppUserKey.stripeID : ""]
            
            self.db.collection(AppFirebaseKey.users).document( UserHelper.getUserIDFromUserDefaults()).setData(user)
            SwiftSpinner.show("SAVEING CARD")
            let seconds = 10.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                self.db.collection(AppFirebaseKey.users)
                    .addSnapshotListener { documentSnapshot, error in
                        guard let document = documentSnapshot else {
                            print("Error fetching document: \(error!)")
                            return
                        }
                        for i in documentSnapshot!.documents {
                            
                            if i.documentID == UserHelper.getUserIDFromUserDefaults() {
                                let data_result = i.data() as NSDictionary
                                let user_details = data_result
                                print("R_DATA  \(user_details)")
//                                if user_details.value(forKey: "userStripeId") as! String != "" {
                                    UserHelper.saveUserDetail(Details: data_result)
//                                    self.addCard()
                                    print(user_details.value(forKey: "userStripeId") as! String)
                               
                                    let vc = Storyboards.DiningView.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                

                                SwiftSpinner.hide()
//                                }
                            }else{
                                
                            }
                        }
                }
            }
        }
        
        
        
    }
    
    
    @IBAction private func emailBeginEditing(_ sender: TweeAttributedTextField) {
        txt_email.hideInfo()
    }
    
    @IBAction private func emailEndEditing(_ sender: TweeAttributedTextField) {
        if let emailText = sender.text, emailText.isValidEmail == true {
            txt_email.lineColor = AppColor.greenColor
            return
        }else{
            txt_email.lineColor = AppColor.redColor
        }
                sender.showInfo("Email address is incorrect. Check it out")
    }
    
    @IBAction func FirstBeginEditings(_ sender: TweeAttributedTextField) {
        sender.hideInfo()
    }
    
    @IBAction private func FirstEndEditing(_ sender: TweeAttributedTextField) {
        if let text = sender.text, text != "" {
            sender.lineColor = AppColor.greenColor
            return
        }else{
            sender.lineColor = AppColor.redColor
        }
    }
    
    
    
    //MARK:- Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.CardDataLocal.count + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.CardDataLocal.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as? CardViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
            if self.isEditMode == true {
                let card_data = self.CardDataLocal[indexPath.row] as! CardDetail
                cell.txt_cardNumber.text = "**** **** **** \(card_data.last4!)"
                cell.txt_year.text = "\(card_data.exp_year!)"
                cell.txt_month.text = "\(card_data.exp_month!)"
                cell.lbl_cardName.text = "\(self.txt_firstName.text!)"
            }else{
                let card_data = self.CardDataLocal[indexPath.row] as! NSDictionary
                cell.lbl_cardName.text = (card_data.value(forKey: "name") as! String)
                cell.txt_cardNumber.text = (card_data.value(forKey: "number") as! String)
                cell.txt_year.text = "\(card_data.value(forKey: "exp_year")!)"
                cell.txt_month.text = String(card_data.value(forKey: "exp_month") as! Int)
                cell.txt_cvv.text = (card_data.value(forKey: "cvc") as! String)
            }
            
            UIHelper.shadow_View(globeView: cell)
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCardViewCell", for: indexPath) as? AddCardViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            UIHelper.shadow_View(globeView: cell)
            return cell
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < self.CardDataLocal.count  {
            print("1")
            
        }else{
            let vc = Storyboards.AuthenticationView.instantiateViewController(identifier: "CreateCardViewController") as! CreateCardViewController
            let presenter: Presentr = {
                let width = ModalSize.full
                let height = ModalSize.full
                let customType = PresentationType.custom(width: width, height: height, center: .bottomCenter)
                let customPresenter = Presentr(presentationType : customType)
                customPresenter.viewControllerForContext = vc
                customPresenter.roundCorners = true
                customPresenter.cornerRadius = 50
                return customPresenter
            }()
            customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < self.CardDataLocal.count  {
            return CGSize(width:Device.width * 0.8 , height: UIHelper.setAutoSize(size: 190))
        }else{
            self.height_collectionPayment.constant = UIHelper.setAutoSize(size: 185)
            return CGSize(width:UIHelper.setAutoSize(size: 100), height: UIHelper.setAutoSize(size: 145))
        }
        
    }
    
    
    //MARK:- Getting card details
    
    func addCard(){
        let param: [String : Any] = ["cardTokenId" : "tok_visa"]
        ApiManager.shared.PostApiCall(params: param, url: AppUrls.addCard) { (success, data, error) in
            if success {
                print("ADD Card API RESPONSE")
                if self.isEditMode != true {
                    let vc = Storyboards.DiningView.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                SwiftSpinner.hide()
            }else{
                print("ADD CARD FAIL API RESPONSE")
                print(error)
                SwiftSpinner.show(error)
            }
        }
        
    }
    
    
    func getCardDetails(){
        ApiManager.shared.GetApiCall(url: AppUrls.getCards) { (success, data, error) in
            print("ALL CARDS : ",data)
            if success {
                print("SUCCESS Card details Detail API RESPONSE")
                let data = data!
                let message = data.value(forKey: "message") as! String
                let status = data.value(forKey: "status") as! Int
                if status != 0 {
                    let result = (data.value(forKey: "data") as! NSArray).mutableCopy() as? NSMutableArray
                    print("MESSAGE  : \(message)")
                    print("RESULT : \(result)")
                    self.CardDataLocal.removeAllObjects()
                    print(self.CardData.count)
                    for card in result! {
                        let card_data = card as! NSDictionary
                        let c_data : CardDetail = CardDetail()
                        c_data.id = (card_data.value(forKey: "id") as! String)
                        c_data.name = card_data.value(forKey: "name") as? String
                        c_data.brand = (card_data.value(forKey: "brand")as! String)
                        c_data.last4 = (card_data.value(forKey: "last4")as? String)
                        c_data.exp_month = "\(card_data.value(forKey: "exp_month")!)"
                        c_data.exp_year = "\(card_data.value(forKey: "exp_year")!)"
                        
                        self.CardDataLocal.add(c_data)
                    }
                    self.collection_paymentsCards.reloadData()
                }else{
                    SwiftSpinner.show(message)
                }
                
            }else{
                UserHelper.logout()
                self.navigationController?.popToRootViewController(animated: true)
                
            }
        }
    }
    
    
}
