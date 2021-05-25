//
//  OrderDetailsController.swift
//  Roll
//
//  Created by tagline13 on 03/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class OrderDetailsController:  UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_name: UIView!
    @IBOutlet weak var top_view_name: NSLayoutConstraint!
    @IBOutlet weak var leading_view_name: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_name: NSLayoutConstraint!
    @IBOutlet weak var height_view_name: NSLayoutConstraint!
    @IBOutlet weak var img_order: UIImageView!
    @IBOutlet weak var lbl_order_date: UILabel!
    @IBOutlet weak var lbl_order_name: UILabel!
    @IBOutlet weak var lbl_order_price: UILabel!
    @IBOutlet weak var top_img_order: NSLayoutConstraint!
    @IBOutlet weak var leading_img_order: NSLayoutConstraint!
    @IBOutlet weak var bottom_img_order: NSLayoutConstraint!
    @IBOutlet weak var view_orderDetails: UIView!
    @IBOutlet weak var top_view_orderdetails: NSLayoutConstraint!
    @IBOutlet weak var leading_view_orderdetails: NSLayoutConstraint!
    @IBOutlet weak var bottom_view_details: NSLayoutConstraint!
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
    
    
    @IBOutlet weak var btn_report: UIButton!
    @IBOutlet weak var top_btn_report: NSLayoutConstraint!
    @IBOutlet weak var height_view_detail: NSLayoutConstraint!
    
    @IBOutlet weak var top_view_details: NSLayoutConstraint!
    @IBOutlet weak var leading_view_detail: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_details: NSLayoutConstraint!
    
    var origional_height = CGFloat()
     var isShowDetail : Bool?
    var OrderDetail = OrderDetails()
    var ItemMenuArray =  NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "OrderItemListViewCell", bundle: nil)
        collection_orderItems.register(nib, forCellWithReuseIdentifier: "OrderItemListViewCell")
        self.origional_height = self.height_view_detail.constant - self.collection_orderItems.bounds.height
        self.isShowDetail = true
        print(OrderDetail.businessName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setData()
        self.setFont()
        self.setLayout()
    }
    
    func setFont(){
        self.lbl_order_name.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.lbl_order_price.font = AppFont.MuseoSansCyrl_500(fontSize: 14)
        self.lbl_order_date.font = AppFont.MuseoSansCyrl_500(fontSize: 12)
        self.btn_report.titleLabel?.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
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
        
        self.top_view_name.constant = UIHelper.setAutoSize(size: 47)
        self.leading_view_name.constant = UIHelper.setAutoSize(size: 45)
        self.trailing_view_name.constant = UIHelper.setAutoSize(size: 45)
        self.height_view_name.constant    = UIHelper.setAutoSize(size: 100)
        
        self.leading_view_detail.constant = UIHelper.setAutoSize(size: 54)
        self.top_btn_report.constant = UIHelper.setAutoSize(size: 18)
        self.top_lbldate.constant = UIHelper.setAutoSize(size: 11)
        
        self.top_img_order.constant = UIHelper.setAutoSize(size: 15)
        self.leading_img_order.constant = UIHelper.setAutoSize(size: 15)
        self.bottom_img_order.constant = UIHelper.setAutoSize(size: 15)
        self.top_view_orderdetails.constant = UIHelper.setAutoSize(size: 15)
        self.leading_view_orderdetails.constant = UIHelper.setAutoSize(size: 15)
        self.bottom_view_details.constant = UIHelper.setAutoSize(size: 15)
        
        self.lbl_order_name.textColor = AppColor.darkgrayColor
        self.lbl_total_value.textColor  = AppColor.greenColor
        self.lbl_detailName.textColor = AppColor.blueColor
        
        UIHelper.courner_View(globeView: self.view_name, redius: UIHelper.setAutoSize(size: 20))
        UIHelper.shadow_View(globeView: self.view_name)
        UIHelper.courner_View(globeView: self.img_order, redius: UIHelper.setAutoSize(size: 25))
    }
    
    func setData(){
        self.lbl_order_name.text = "\(self.OrderDetail.businessName!)"
        self.lbl_order_price.text = OrderDetail.subTotal as! String
        self.lbl_detailName.text = "Lilia"
        self.lbl_order_date.text = "09:51 PM  4/18/2020"
        self.lbl_subtotal_value.text = OrderDetail.subTotal as! String
        self.lbl_fees.text = AppString.fess
        self.lbl_discount.text = AppString.discount
        self.lbl_total.text = AppString.totalbill
        self.lbl_discount_value.text = "-$10.0"
        self.lbl_fees_value.text = OrderDetail.taxAmount as! String
        self.lbl_total_value.text = OrderDetail.grandTotal as! String
        self.lbl_date.text = "09:51 PM  4/18/2020"
        self.btn_report.setTitle(AppButtons.reportIssue, for: .normal)
        
        
        
        for item in self.OrderDetail.items!{
                            let itemData : ItemMenu = ItemMenu()
                            itemData.name = (item as AnyObject).value(forKey: "name") as! String
                            itemData.price = (item as AnyObject).value(forKey: "price") as! Int
                            self.ItemMenuArray.add(itemData)
                        }
        self.collection_orderItems.reloadData()
    }
    
 
    
    //MARK:- IBActions methods of buttons
    
    @IBAction func btn_report_tapped(_ sender: Any) {
    }
 
    
    //MARK:- Collectionview Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderItemListViewCell", for: indexPath) as? OrderItemListViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.lbl_name.textColor = AppColor.blackColor
        cell.lbl_price.textColor = AppColor.blackColor
        let Items = ItemMenuArray[indexPath.row] as! ItemMenu
        cell.lbl_name.text = Items.name
        cell.lbl_price.text = "\(Items.price!)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: UIHelper.setAutoSize(size: 35))
    }
}
