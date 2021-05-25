//
//  CreateCardViewController.swift
//  Roll
//
//  Created by tagline13 on 23/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import MFCard
import Stripe
import SwiftSpinner

protocol PassCardDelegate {
    func GetCard(Data : NSMutableDictionary)
}


class CreateCardViewController: UIViewController,MFCardDelegate {
    
    
    
    @IBOutlet weak var lbl_add_payment: UILabel!
    @IBOutlet weak var creditCard: MFCardView!
    @IBOutlet weak var btn_credit: UIButton!
    @IBOutlet weak var btn_debit: UIButton!
    @IBOutlet weak var btn_applepay: UIButton!
    @IBOutlet weak var btn_addCard: UIButton!
    @IBOutlet weak var top_lbl_addPayment: NSLayoutConstraint!
    @IBOutlet weak var height_cardView: NSLayoutConstraint!
    @IBOutlet weak var leading_view_card: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_card: NSLayoutConstraint!
    @IBOutlet weak var top_view_card: NSLayoutConstraint!
    @IBOutlet weak var top_btn_scanCard: NSLayoutConstraint!
    @IBOutlet weak var top_view_buttons: NSLayoutConstraint!
    @IBOutlet weak var leading_view_buttons: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_buttons: NSLayoutConstraint!
    @IBOutlet weak var top_btn_addcard: NSLayoutConstraint!
    @IBOutlet weak var leading_btn_addcard: NSLayoutConstraint!
    @IBOutlet weak var height_btn_addcard: NSLayoutConstraint!
    @IBOutlet weak var trailing_btn_addcard: NSLayoutConstraint!
    
    
    var Card : Card?
    let localCard = NSMutableDictionary()
    var error : String?
    static var delegate : PassCardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_addCard.isEnabled = false
        self.btn_addCard.layer.opacity = 0.5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
        setFont()
        setCard()
        setLayout()
        
        
    }
    // MARK:- Cutom functions
    func setLayout(){
        self.top_lbl_addPayment.constant = UIHelper.setAutoSize(size: 32)
        self.top_view_card.constant = UIHelper.setAutoSize(size: 0)
        self.leading_view_card.constant = UIHelper.setAutoSize(size: 47)
        self.trailing_view_card.constant = UIHelper.setAutoSize(size: 47)
        //        self.height_cardView.constant = UIHelper.setAutoSize(size: 230)
        self.top_btn_scanCard.constant = UIHelper.setAutoSize(size: 37)
        self.top_view_buttons.constant = UIHelper.setAutoSize(size: 59)
        self.leading_view_buttons.constant = UIHelper.setAutoSize(size: 89)
        self.trailing_view_buttons.constant = UIHelper.setAutoSize(size: 63)
        self.top_btn_addcard.constant = UIHelper.setAutoSize(size: 35)
        self.leading_btn_addcard.constant = UIHelper.setAutoSize(size: 92)
        self.trailing_btn_addcard.constant = UIHelper.setAutoSize(size: 92)
        self.height_btn_addcard.constant = UIHelper.setAutoSize(size: 50)
        self.btn_addCard.titleLabel?.tintColor = AppColor.whiteColor
        self.btn_addCard.layer.backgroundColor = AppColor.blueColor.cgColor
        UIHelper.courner_View(globeView: self.btn_addCard, redius: 20)
    }
    
    func setFont(){
        self.lbl_add_payment.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.btn_applepay.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 17)
        self.btn_credit.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 17)
        self.btn_debit.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 17)
        self.btn_addCard.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 17)
    }
    
    func setCard(){
        creditCard.autoDismiss = false
        creditCard.toast = false
        creditCard.delegate = self
        creditCard.controlButtonsRadius = 5
        creditCard.cardRadius = 5
        creditCard.tintColor = AppColor.blueColor
        creditCard.frontChromeColor = AppColor.blueColor
    }
    
    func setData(){
        self.lbl_add_payment.text =  AppString.addPaymentMethod
        self.btn_debit.setTitle(AppButtons.debit, for: .normal)
        self.btn_credit.setTitle(AppButtons.credit, for: .normal)
        self.btn_applepay.setTitle(AppButtons.applePay, for: .normal)
        self.btn_addCard.setTitle(AppButtons.addCard, for: .normal)
    }
    
    //MARK:- MFCard Delegate methods
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        self.btn_addCard.isEnabled = true
        if error == nil{
            print(card!)
            self.Card = card
            self.btn_addCard.layer.opacity = 1.0
        }else{
            self.error = error
        }
    }
    
    
    
    func cardTypeDidIdentify(_ cardType: String) {
        print(cardType)
    }
    
    func cardDidClose() {
        print("Card Close")
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getToken(){
        
        SwiftSpinner.show("Adding your card...")
        let cardParams = STPCardParams()
        cardParams.number = self.Card!.number!
        cardParams.expMonth = UInt(self.Card!.month!.rawValue)!
        cardParams.expYear = UInt(self.Card!.year!)!
        cardParams.cvc = self.Card!.cvc!
        cardParams.name = self.Card!.name!
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                print(error as Any)
                return
            }
            print(token.tokenId)
            print(token.livemode)
            print(token.type)
            print(token.card as Any)
            print(token.bankAccount as Any)
            print(token.created as Any)
            let params = ["number": self.Card!.number! as Any , "exp_month":UInt(self.Card!.month!.rawValue)!  , "exp_year" : UInt(self.Card!.year!)!, "cvc" :self.Card!.cvc! , "name" : self.Card!.name! as Any , "tokenObject" : token , "cardTokenId" :token.tokenId ] as [String : Any ]
            print(params)
            self.localCard.addEntries(from: params)
            if CreateCardViewController.delegate != nil {
                SwiftSpinner.hide()
                self.dismiss(animated: true, completion: nil)
                CreateCardViewController.delegate?.GetCard(Data: self.localCard)
            }
            else{
                print("delegate is nil")
            }
            print(self.localCard)
        }
        
        
        
        
        
        //            ApiManager.shared.PostApiCall(params:params, url: AppUrls.addFirstCArd) { (success, data, error) in
        //                print(success , data as Any , error)
        //                if success {
        //                    print("SUCCESS RESPONSE : \(data as Any)")
        //                    let responsedata = data!
        //                    print(responsedata)
        //                    let data_status = responsedata.value(forKey: "status") as! Int
        //                    let data_message = responsedata.value(forKey: "message") as! String
        //                    if data_status == 1 {
        //                        let data_result = responsedata.value(forKey: "data") as! NSDictionary
        //                        let data_card = data_result.value(forKey: "card") as! NSDictionary
        //                        print(data_card)
        //                        print("++++++++++++++")
        //                        let c_data : CardDetail = CardDetail()
        //                        c_data.id = (data_card.value(forKey: "id") as! String)
        //                        c_data.last4 = (data_card.value(forKey: "last4") as! String)
        //                        c_data.exp_month = (data_card.value(forKey: "exp_month") as! Int)
        //                        c_data.exp_year = (data_card.value(forKey: "exp_year") as! Int)
        //                        c_data.name = data_card.value(forKey: "name") as? String
        //                        c_data.brand = (data_card.value(forKey: "brand") as! String)
        //                        self.localCard.add(c_data)
        //                        let vc = Storyboards.AuthenticationView.instantiateViewController(identifier: "CreateAccountViewController") as! CreateAccountViewController
        //                        vc.CardDataLocal = self.localCard
        //
        //                        if CreateCardViewController.delegate != nil {
        //                            self.dismiss(animated: true, completion: nil)
        //                            CreateCardViewController.delegate?.GetCard(Data: self.localCard)
        //
        //                        }
        //                        else{
        //                            print("delegate is nil")
        //                        }
        //
        //                    }else{
        //                        SwiftSpinner.show("Adding your card...").addTapHandler({
        //                            SwiftSpinner.hide()
        //                        }, subtitle: data_message)
        //
        //                    }
        //                }else{
        //                    print(error)
        //                    SwiftSpinner.show("Adding your card...").addTapHandler({
        //                        SwiftSpinner.hide()
        //                    }, subtitle: error)
        //                }
        //            }
    }
    
    @IBAction func btn_addCard_tapped(_ sender: Any) {
        
        if self.error == nil{
            getToken()
            self.dismiss(animated: true, completion: nil)
            self.view.makeToast("Card added")
        }else{
            SwiftSpinner.show("Adding your card...").addTapHandler({
                SwiftSpinner.hide()
            }, subtitle: self.error!)
        }
    }
}
