//
//  OrderHistoryController.swift
//  Roll
//
//  Created by tagline13 on 02/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import Presentr
import FirebaseFirestore

class OrderHistoryController:UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

@IBOutlet weak var lbl_order: UILabel!
@IBOutlet weak var collection_orders: UICollectionView!

@IBOutlet weak var top_lbl_order: NSLayoutConstraint!
@IBOutlet weak var leading_lbl_order: NSLayoutConstraint!
@IBOutlet weak var trailing_lbl_order: NSLayoutConstraint!
@IBOutlet weak var top_collection_orders: NSLayoutConstraint!
@IBOutlet weak var leading_collection_orders: NSLayoutConstraint!
@IBOutlet weak var trailing_collection_orders: NSLayoutConstraint!
@IBOutlet weak var bottom_collection_orders: NSLayoutConstraint!

    let db = Firestore.firestore()
    var OrderList = Array<OrderDetails>()
    
 //MARK:- ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setFont()
        setLayout()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "OrderHistoryViewCell", bundle: nil)
        collection_orders.register(nib, forCellWithReuseIdentifier: "OrderHistoryViewCell")
        getOrderList()
    }
    
    
    
    //MARK:- Custom Functions
    
    func setNavigation() {
        
        
        self.navigationController?.navigationBar.backgroundColor = AppColor.clear
//         let BackButton = UIBarButtonItem(image: UIImage(named: "back-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
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
        self.lbl_order.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
    }
    
    func setLayout(){
        
        self.top_lbl_order.constant = UIHelper.setAutoSize(size: 30)
        self.leading_lbl_order.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_lbl_order.constant = UIHelper.setAutoSize(size: 30)
        self.leading_collection_orders.constant = UIHelper.setAutoSize(size: 0)
        self.top_collection_orders.constant = UIHelper.setAutoSize(size: 20)
        self.bottom_collection_orders.constant = UIHelper.setAutoSize(size: 10)
        self.trailing_collection_orders.constant = UIHelper.setAutoSize(size: 10)
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    func setData(){
        self.lbl_order.text = AppString.orderHistory
    }
    
    @objc func CheckIn_button_tapped(_ sender: UIButton?) {
        print("tapped button")
        let vc = Storyboards.DiningView.instantiateViewController(identifier: "CheckInViewController") as! CheckInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getOrderList(){
        
//        EOQbPUfF87Rpl96I7zM3
       db.collection(AppFirebaseKey.orders)
        .addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.OrderList.removeAll()
                for i in snapshot!.documents {
                    if i.documentID == "6XYLi4QmQKPkhdvEheCk" {
                        let data_result = i.data() as NSDictionary
                        let order_details = data_result
                        let o_data : OrderDetails = OrderDetails()
                        
//                        self.testItmes = order_details.value(forKey: "items") as! NSMutableArray
                        o_data.items = (order_details.value(forKey: "items") as! NSArray)
                        o_data.businessName = "\((order_details.value(forKey: "businessName") as! String))"
                        o_data.updatedAt = (order_details.value(forKey: "updatedAt") as! String)
                        o_data.subTotal = (order_details.value(forKey: "subTotal") as Any)
                        o_data.taxAmount = (order_details.value(forKey: "taxAmount") as Any)
                        o_data.subTotal = (order_details.value(forKey: "subTotal") as Any)
                        o_data.grandTotal = (order_details.value(forKey: "grandTotal") as Any)
                        self.OrderList.append(o_data)
                    }
                }
                 self.collection_orders.reloadData()
            }
        }
    }
    
    
    //MARK:- Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OrderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderHistoryViewCell", for: indexPath) as? OrderHistoryViewCell else {
                fatalError("can't dequeue CustomCell")
            }
        let Order = OrderList[indexPath.row]
        cell.lbl_order_name.text = Order.businessName
        cell.lbl_order_price.text = (Order.grandTotal as! String)
        
        cell.lbl_order_date.text = "11:20 PM 4/16/2020"
        UIHelper.courner_View(globeView: cell.view_main, redius: UIHelper.setAutoSize(size: 20))
        UIHelper.shadow_View(globeView: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller  = Storyboards.ProfileView.instantiateViewController(identifier: "OrderDetailsController") as! OrderDetailsController
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
        let orderDetail = self.OrderList[indexPath.row] as! OrderDetails
        controller.OrderDetail = orderDetail
        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width:collectionView.bounds.width - 20, height: UIHelper.setAutoSize(size: 100))
        return CGSize(width: UIHelper.setAutoSize(size: 320), height: UIHelper.setAutoSize(size: 100))
    }
    
}
