//
//  CheckoutViewController.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import Presentr

class CheckoutViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_name: UIView!
    
    @IBOutlet weak var top_view_name: NSLayoutConstraint!
    @IBOutlet weak var leading_view_name: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_name: NSLayoutConstraint!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var view_server: UIView!
    @IBOutlet weak var top_view_server: NSLayoutConstraint!
    @IBOutlet weak var leading_view_server: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_server: NSLayoutConstraint!
    @IBOutlet weak var height_view_server: NSLayoutConstraint!
    
    @IBOutlet weak var img_server: UIImageView!
    @IBOutlet weak var lbl_server: UILabel!
    @IBOutlet weak var lbl_serverName: UILabel!
    
    
    @IBOutlet weak var view_bill: UIView!
    @IBOutlet weak var top_view_bill: NSLayoutConstraint!
    @IBOutlet weak var leading_view_bill: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_bill: NSLayoutConstraint!
    @IBOutlet weak var view_billItems: UIView!
    @IBOutlet weak var top_view_billitems: NSLayoutConstraint!
    @IBOutlet weak var bottom_view_billitems: NSLayoutConstraint!
    @IBOutlet weak var lbl_totalPrice: UILabel!
    @IBOutlet weak var lbl_totalPriceValue: UILabel!
    
    @IBOutlet weak var view_billdetails: UIView!
    @IBOutlet weak var lbl_detailName: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var top_lbldate: NSLayoutConstraint!
    
    @IBOutlet weak var collection_orderItems: UICollectionView!
    @IBOutlet weak var top_collection_orderItems: NSLayoutConstraint!
    @IBOutlet weak var height_collection_orderItems: NSLayoutConstraint!
    @IBOutlet weak var view_border: UIView!
    @IBOutlet weak var view_count: UIView!
    @IBOutlet weak var lbl_subtotal: UILabel!
    @IBOutlet weak var lbl_subtotal_value: UILabel!
    
    @IBOutlet weak var lbl_fees: UILabel!
    @IBOutlet weak var lbl_fees_value: UILabel!
    
    @IBOutlet weak var lbl_discount: UILabel!
    @IBOutlet weak var lbl_discount_value: UILabel!
    
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var lbl_total_value: UILabel!
    
    @IBOutlet weak var top_btn_show: NSLayoutConstraint!
    @IBOutlet weak var btn_showHide: UIButton!
    
    @IBOutlet weak var btn_report: UIButton!
    @IBOutlet weak var top_btn_report: NSLayoutConstraint!
    
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var top_btn_done: NSLayoutConstraint!
    @IBOutlet weak var bottom_btn_done: NSLayoutConstraint!
    @IBOutlet weak var trailing_btn_done: NSLayoutConstraint!
    @IBOutlet weak var leading_btn_done: NSLayoutConstraint!
    @IBOutlet weak var height_view_detail: NSLayoutConstraint!
    
    @IBOutlet weak var top_view_details: NSLayoutConstraint!
    @IBOutlet weak var leading_view_detail: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_details: NSLayoutConstraint!
    
    @IBOutlet weak var view_dashborder1: UIView!
    @IBOutlet weak var view_dashborder2: UIView!
    
    var origional_height = CGFloat()
     var isShowDetail : Bool?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "OrderItemListViewCell", bundle: nil)
        collection_orderItems.register(nib, forCellWithReuseIdentifier: "OrderItemListViewCell")
        self.origional_height = self.height_view_detail.constant - self.collection_orderItems.bounds.height
        self.isShowDetail = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.HideSHow()
        self.setData()
        self.setFont()
        self.setLayout()
    }
    
    func setFont(){
        self.lbl_status.font = AppFont.MuseoSansCyrl_700(fontSize: 18)
        self.lbl_name.font = AppFont.MuseoSansCyrl_700(fontSize: 25)
        self.lbl_server.font = AppFont.MuseoSansCyrl_500(fontSize: 13)
        self.lbl_serverName.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
         self.lbl_totalPrice.font = AppFont.MuseoSansCyrl_700(fontSize: 16)
         self.lbl_totalPriceValue.font = AppFont.MuseoSansCyrl_700(fontSize: 16)
        self.btn_showHide.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.btn_report.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.btn_done.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
        
        self.lbl_detailName.font = AppFont.MuseoSansCyrl_700(fontSize: 25)
        self.lbl_date.font = AppFont.MuseoSansCyrl_500(fontSize: 13)
        self.lbl_subtotal.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_discount.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_fees.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_total.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_subtotal_value.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_fees_value.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_discount_value.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        self.lbl_total_value.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
        
    }
    
    func setLayout(){
        self.top_view_name.constant = UIHelper.setAutoSize(size: 31)
        self.leading_view_name.constant = UIHelper.setAutoSize(size: 95)
        self.trailing_view_name.constant = UIHelper.setAutoSize(size: 95)
        self.top_view_server.constant = UIHelper.setAutoSize(size: 47)
        self.leading_view_server.constant = UIHelper.setAutoSize(size: 45)
        self.trailing_view_server.constant = UIHelper.setAutoSize(size: 45)
        self.height_view_server.constant    = UIHelper.setAutoSize(size: 55)
        self.leading_view_bill.constant = UIHelper.setAutoSize(size: 37)
        self.trailing_view_bill.constant = UIHelper.setAutoSize(size: 37)
        self.top_btn_show.constant = UIHelper.setAutoSize(size: 23)
        self.top_view_billitems.constant = UIHelper.setAutoSize(size: 10)
        self.bottom_view_billitems.constant = UIHelper.setAutoSize(size: 10)
        self.leading_view_detail.constant = UIHelper.setAutoSize(size: 54)
         self.top_btn_report.constant = UIHelper.setAutoSize(size: 18)
        self.top_lbldate.constant = UIHelper.setAutoSize(size: 11)
        
        self.lbl_server.textColor = AppColor.darkgrayColor
        self.lbl_total_value.textColor  = AppColor.greenColor
        self.lbl_totalPriceValue.textColor  = AppColor.redColor
        self.lbl_detailName.textColor = AppColor.blueColor
        
        self.btn_done.layer.backgroundColor = AppColor.blueColor.cgColor
        UIHelper.courner_View(globeView: self.img_server, redius: UIHelper.setAutoSize(size: self.img_server.bounds.height/2))
        UIHelper.courner_View(globeView: self.btn_done, redius: UIHelper.setAutoSize(size: 20))
    }
    
    func setData(){
        setAttributedText()
        self.lbl_name.text = "Joyce Garden"
        self.lbl_server.text = "Your server"
        self.lbl_serverName.text = "Jessica"
        self.lbl_detailName.text = "Lilia"
        self.lbl_subtotal_value.text = AppString.subtotal
        self.lbl_fees.text = AppString.fess
        self.lbl_discount.text = AppString.discount
        self.lbl_total.text = AppString.totalbill
        self.lbl_totalPrice.text = AppString.totalbill
        self.lbl_subtotal_value.text = "$80.70"
        self.lbl_discount_value.text = "-$10.0"
        self.lbl_fees_value.text = "$10.66"
        self.lbl_total_value.text = "76.57"
        self.lbl_totalPriceValue.text = "$97.74"
        self.lbl_date.text = "09:51 PM  4/18/2020"
        self.btn_showHide.setTitle("SHOW DETAILS", for: .normal)
        self.btn_report.setTitle(AppButtons.reportIssue, for: .normal)
        self.btn_done.setTitle(AppButtons.done, for: .normal)
    }
    
    func setAttributedText(){
           let firstAttributes = [NSAttributedString.Key.foregroundColor: AppColor.blackColor]
           let secondAttributes = [NSAttributedString.Key.foregroundColor: AppColor.blueColor]
           
           let firstString = NSMutableAttributedString(string: "You’re ", attributes: firstAttributes)
           let secondString = NSMutableAttributedString(string: "Checked Out ", attributes: secondAttributes)
           let thiredString = NSAttributedString(string: "of", attributes: firstAttributes)
            secondString.append(thiredString)
           firstString.append(secondString)
           self.lbl_status.attributedText = firstString
           
       }
    
    func HideSHow(){
        if self.isShowDetail == true {
                       self.height_view_detail.constant = 0
                        self.top_view_details.constant = 0
            self.top_btn_report.constant = 0

            self.view_billdetails.isHidden = true
             
                       self.btn_showHide.setTitle("See Details", for: .normal)
                   }else{
                       let cell_height = Double(UIHelper.setAutoSize(size: 35 + 10)) * Double(3)
                       self.height_collection_orderItems.constant = CGFloat(cell_height)
                       self.height_view_detail.constant = self.origional_height + height_collection_orderItems.constant
            self.top_view_details.constant = 35
            self.top_btn_report.constant = 18
                       self.view_billdetails.isHidden = false
            self.btn_report.isHidden = false
                       self.btn_showHide.setTitle("Hide Details", for: .normal)
                   }
    }
    
    //MARK:- IBActions methods of buttons
    @IBAction func btn_showHide_tapped(_ sender: Any) {
        self.isShowDetail = !self.isShowDetail!
        print(self.isShowDetail)
        self.HideSHow()
    }
    
    @IBAction func btn_report_tapped(_ sender: Any) {
    }
    @IBAction func btn_done_tapped(_ sender: Any) {
        let vc = Storyboards.DiningView.instantiateViewController(identifier:  "ReviewController") as! ReviewController
         customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    //MARK:- Collectionview Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderItemListViewCell", for: indexPath) as? OrderItemListViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.lbl_name.textColor = AppColor.blackColor
        cell.lbl_price.textColor = AppColor.blackColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: UIHelper.setAutoSize(size: 35))
    }
}
