//
//  TestViewController.swift
//  Roll
//
//  Created by tagline13 on 25/06/20.
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
import SkyFloatingLabelTextField

class TestViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate {
    
    @IBOutlet var view_datePicker: UIView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var lbl_createAccount: UILabel!
    @IBOutlet weak var view_name: UIStackView!
    @IBOutlet weak var lbl_firstName: UILabel!
    @IBOutlet weak var txt_firstName: SkyFloatingLabelTextField!
    @IBOutlet weak var lbl_lastName: UILabel!
    @IBOutlet weak var txt_lastName: SkyFloatingLabelTextField!
    @IBOutlet weak var viiew_age: UIView!
    @IBOutlet weak var lbl_age: UILabel!
    @IBOutlet weak var txt_age: UITextField!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var txt_email: SkyFloatingLabelTextField!
    @IBOutlet weak var lbl_addPayment: UILabel!
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
    
    var isEditMode : Bool? = nil
    var db = Firestore.firestore()
    var CardData = NSMutableArray()
    
    
    // MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txt_email.delegate = self
        self.txt_firstName.delegate = self
        self.txt_lastName.delegate = self
        
        
//        txt_email.selectedTitle = NSLocalizedString(
//                   "Email",
//                   tableName: "SkyFloatingLabelTextField",
//                   comment: "selected title for Email field"
//               )
//               txt_email.title = NSLocalizedString(
//                   "Email",
//                   tableName: "SkyFloatingLabelTextField",
//                   comment: "title for Email field"
//               )

               applySkyscannerTheme(textField: txt_email)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
        setFont()
        //setData()
        setNavigation()
        setDatePicker()
        let nib = UINib(nibName: "CardViewCell", bundle: nil)
        collection_paymentsCards.register(nib, forCellWithReuseIdentifier: "CardViewCell")
        
        let nib1 = UINib(nibName: "AddCardViewCell", bundle: nil)
        collection_paymentsCards.register(nib1, forCellWithReuseIdentifier: "AddCardViewCell")
        //        self.collection_paymentsCards.isHidden = true
        self.CardData.add([:])
        self.CardData.add([:])
         self.CardData.add([:])
        if self.isEditMode == true {
            getCardDetails()
            self.isEditingData()
            
        }
        
        
        
    }
    
    // MARK: - Custom views
    func setFont(){
        self.lbl_createAccount.font = AppFont.MuseoSansCyrl_700(fontSize: 30)
        self.lbl_firstName.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.lbl_lastName.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.lbl_age.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.lbl_email.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.lbl_addPayment.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.btn_createAccount.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 24)
        self.txt_age.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.txt_email.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.txt_lastName.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.txt_firstName.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
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
        self.top_view_name.constant = UIHelper.setAutoSize(size: 30)
        self.top_view_age.constant = UIHelper.setAutoSize(size: 20)
        self.top_view_email.constant = UIHelper.setAutoSize(size: 20)
        self.top_lbl_payment.constant = UIHelper.setAutoSize(size: 20)
        self.top_btn_createAccount.constant = UIHelper.setAutoSize(size: 20)
        
        self.height_view_age.constant = UIHelper.setAutoSize(size: 60)
        self.height_view_name.constant = UIHelper.setAutoSize(size: 60)
        self.height_view_email.constant = UIHelper.setAutoSize(size: 100)
        self.height_collectionPayment.constant = UIHelper.setAutoSize(size: 240)
        self.height_btn_account.constant = UIHelper.setAutoSize(size: 50)
        
//        UIHelper.BottomBorder_TextField(globeView: txt_firstName)
//        UIHelper.BottomBorder_TextField(globeView: txt_lastName)
//        UIHelper.BottomBorder_TextField(globeView: txt_email)
//        UIHelper.BottomBorder_TextField(globeView: txt_age)
        
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
        datepicker.maximumDate = Date()
    }
    
    func setData(){
        self.lbl_createAccount.text = AppString.createAcount
        self.txt_firstName.placeholder = AppPlaceHolders.firstName
        self.txt_lastName.placeholder = AppPlaceHolders.lastName
        self.txt_email.placeholder = AppPlaceHolders.lastName
        self.btn_createAccount.setTitle(AppButtons.createAccount, for: .normal)
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = AppColor.clear
        let BackButton = UIBarButtonItem(image: UIImage(named: "back-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem  = BackButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func isEditingData(){
        self.collection_paymentsCards.isHidden = false
        let userDetails = UserHelper.getUserDetails()
        self.lbl_createAccount.text = AppString.editAccount
        self.txt_firstName.text = (userDetails.value(forKey: AppUserKey.firstName) as! String)
        self.txt_lastName.text = (userDetails.value(forKey: AppUserKey.lastName) as! String)
        self.txt_age.text = (userDetails.value(forKey: AppUserKey.age) as! String)
        //        self.txt_email.text = UserDetails.value(forKey: AppUserKey.email) as! String
        self.btn_createAccount.setTitle(AppButtons.save, for: .normal)
        
    }
    
    
    //MARK:- Custom button Actions
    
    @IBAction func btn_age_Tapped(_ sender: Any) {
        print("1")
        txt_age.becomeFirstResponder()
    }
    
    @IBAction func Btn_OK_Tapped(_ sender: Any) {
        txt_age.resignFirstResponder()
        let theFormatter = DateFormatter()
        theFormatter.dateStyle = .full
        let theStringDate = theFormatter.string(from: self.datepicker.date)
        
        let theFormatterDate = DateFormatter()
        theFormatterDate.dateFormat = "yyyy-MM-dd"
        let theDate = theFormatterDate.string(from: self.datepicker.date)
        print(theDate)
        self.txt_age.text = theStringDate
        
    }
    
    @IBAction func Btn_CANCEL_Tapped(_ sender: Any) {
        txt_age.resignFirstResponder()
    }
    
    @IBAction func btn_createAccount_Tapped(_ sender: Any) {
        
        if self.isEditMode == true {
            let user :[String : Any] = [AppUserKey.userId: UserHelper.getUserIDFromUserDefaults(), AppUserKey.firstName: self.txt_firstName.text!, AppUserKey.lastName: self.txt_lastName.text!, AppUserKey.squareCustomerId: "", AppUserKey.email: self.txt_email.text!, AppUserKey.age: self.txt_age.text! , ]
            
            do {
                try self.db.collection(AppFirebaseKey.users).document( UserHelper.getUserIDFromUserDefaults()).updateData(user)
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
        }else{
            let user :[String : Any] = [AppUserKey.userId: UserHelper.getUserIDFromUserDefaults(), AppUserKey.firstName: self.txt_firstName.text!, AppUserKey.lastName: self.txt_lastName.text!, AppUserKey.squareCustomerId: "", AppUserKey.email: self.txt_email.text!, AppUserKey.age: self.txt_age.text!, AppUserKey.profilePictureUrl: "", AppUserKey.userType: "user", AppUserKey.phone: Auth.auth().currentUser?.phoneNumber]
            
            do {
                try self.db.collection(AppFirebaseKey.users).document( UserHelper.getUserIDFromUserDefaults()).setData(user)
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
        }
        
        
        
        db.collection(AppFirebaseKey.users).document(UserHelper.getUserIDFromUserDefaults())
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                UserHelper.saveUserDetail(Details: document.data() as NSDictionary? ?? [:] as NSDictionary)
                print("\(source) data: \(document.data() ?? [:])")
        }
        //                let vc = Storyboards.DiningView.instantiateViewController(identifier: "DiningViewController") as! DiningViewController
        //                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK:- Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return self.CardData.count
        if self.CardData.count == 0 {
            return 1
        }else{
            return self.CardData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.CardData.count == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCardViewCell", for: indexPath) as? AddCardViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            UIHelper.shadow_View(globeView: cell)
            return cell
        }else{
                        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as? CardViewCell else {
                            fatalError("can't dequeue CustomCell")
                        }
//                        let cardData = CardData[indexPath.row] as! CardDetail
//                        cell.lbl_cardNumber.text = " **** \(cardData.last4!)"
//                        cell.lbl_cardName.text = "\(cardData.brand!)"
//                        cell.lbl_name.text = "\(cardData.name ?? self.txt_firstName.text!)`s Credit"
                        UIHelper.shadow_View(globeView: cell)
                        return cell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.CardData.count == 0  {
            print("1")
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
            
//            let controller = SheetViewController(controller: Storyboards.AuthenticationView.instantiateViewController(identifier: "CreateCardViewController") as! CreateCardViewController)
//            controller.blurBottomSafeArea = false
//            self.present(controller, animated: false, completion: nil)
        }
        
    }
    
    @objc func btnClickAction(_ sender:UIButton) {
        print("My custom button action")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.CardData.count == 0  {
            return CGSize(width:UIHelper.setAutoSize(size: 150), height: UIHelper.setAutoSize(size: 165))
        }else{
//            let layout = UPCarouselFlowLayout()
//            layout.itemSize = CGSize(width:Device.width * 0.8 , height: UIHelper.setAutoSize(size: 190))tAutoSize())
//            collectionView.collectionViewLayout = layout
            return CGSize(width:Device.width * 0.8 , height: UIHelper.setAutoSize(size: 190))
        }
        
    }
    
    
    //MARK:- Getting card details
    
    func getCardDetails(){
        ApiManager.shared.GetApiCall(url: AppUrls.getCards) { (success, data, error) in
            print("ALL CARDS : ",data)
            if success {
                print("SUCCESS Card details Detail API RESPONSE")
                let data = data!
                let message = data.value(forKey: "message") as! String
                let result = (data.value(forKey: "data") as! NSArray).mutableCopy() as? NSMutableArray
                print("MESSAGE  : \(message)")
                print("RESULT : \(result)")
                self.CardData.removeAllObjects()
                self.CardData.add({})
                print(self.CardData.count)
                for card in result! {
                    let card_data = card as! NSDictionary
                    let c_data : CardDetail = CardDetail()
                    c_data.id = (card_data.value(forKey: "id") as! String)
                    c_data.name = card_data.value(forKey: "name") as? String
                    c_data.brand = (card_data.value(forKey: "brand")as! String)
                    c_data.last4 = (card_data.value(forKey: "last4")as? String)
                    self.CardData.add(c_data)
                }
                self.collection_paymentsCards.reloadData()
            }else{
                UserHelper.logout()
                self.navigationController?.popToRootViewController(animated: true)
                print("FAILULER Club Detail API RESPONSE")
                
            }
        }
    }
    
    // MARK: - Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Validate the email field
        if textField == self.txt_email {
            validateEmailField()
        }

        // When pressing return, move to the next field
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }

    @IBAction func validateEmailField() {
        validateEmailTextFieldWithText(email: self.txt_email.text)
    }

    func validateEmailTextFieldWithText(email: String?) {
        guard let email = email else {
            self.txt_email.errorMessage = nil
            return
        }

        if email.isEmpty {
            self.txt_email.errorMessage = nil
        } else if !validateEmail(email) {
            self.txt_email.errorMessage = NSLocalizedString(
                "Email not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " "
            )
        } else {
            self.txt_email.errorMessage = nil
        }
    }

    // MARK: - validation

    func validateEmail(_ candidate: String) -> Bool {

        // NOTE: validating email addresses with regex is usually not the best idea.
        // This implementation is for demonstration purposes only and is not recommended for production use.
        // Regex source and more information here: http://emailregex.com

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    // MARK: - Styling the text fields to the Skyscanner theme

       func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {

        textField.tintColor = AppColor.blackColor

        textField.textColor = AppColor.greenColor
        textField.lineColor = AppColor.greenColor

//           textField.selectedTitleColor =  AppColor.greenColor
//           textField.selectedLineColor =  AppColor.greenColor
//
//           // Set custom fonts for the title, placeholder and textfield labels
//           textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
//           textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
//           textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
       }
}
