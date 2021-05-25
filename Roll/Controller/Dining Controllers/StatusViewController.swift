//
//  StatusViewController.swift
//  Roll
//
//  Created by tagline13 on 28/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import Presentr
import FittedSheets
import SDWebImage
import FirebaseFirestore



class StatusViewController: UIViewController  {
    
    @IBOutlet weak var img_restaurant: UIImageView!
    
    var Restorunt_Detail = RestaurantsData()
    var TestFavouriteRestoruntData = Array<RestaurantsData>()
    var TestFavouriteRestoruntData2 = Array<RestaurantsData>()
    var orderID : String?
    var db = Firestore.firestore()
    var isFavourite : Bool?
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
        self.img_restaurant.sd_setImage(with: URL(string:Restorunt_Detail.businessPhotoUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        getOrders()
    }
    
    func getOrders() {
        self.db.collection(AppFirebaseKey.orders)
            .addSnapshotListener { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for i in snapshot!.documents {
                        
                        if i.documentID == self.orderID {
                            let data_result = i.data() as NSDictionary
                            let restaurants_details = data_result
                            print("R_DATA  \(restaurants_details)")
                            self.dismiss(animated: true, completion: nil)
                            if restaurants_details.value(forKey: "status") as! String == AppOrderStatusKeys.justarrived {
                                let vc = Storyboards.DiningView.instantiateViewController(identifier:  "CheckInViewController") as! CheckInViewController
                                vc.orderID = self.orderID
                                vc.menuLink = self.Restorunt_Detail.menuLink!
                                self.customPresentViewController(self.presenter1, viewController: vc, animated: true, completion: nil)
                            }else if restaurants_details.value(forKey: "status") as! String == AppOrderStatusKeys.checkin {
                                let vc = Storyboards.DiningView.instantiateViewController(identifier:  "CheckInViewController") as! CheckInViewController
                                vc.orderID = self.orderID
                                vc.menuLink = self.Restorunt_Detail.menuLink!
                                self.customPresentViewController(self.presenter1, viewController: vc, animated: true, completion: nil)
                            }else if restaurants_details.value(forKey: "status") as! String == AppOrderStatusKeys.checkmeout {
                                let vc = Storyboards.DiningView.instantiateViewController(identifier:  "RequestCheckoutController") as! RequestCheckoutController
                                vc.orderID = self.orderID
                                self.customPresentViewController(self.presenter1, viewController: vc, animated: true, completion: nil)
                            }else{
                                let vc = Storyboards.DiningView.instantiateViewController(identifier:  "CheckoutViewController") as! CheckoutViewController
                                self.customPresentViewController(self.presenter1, viewController: vc, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
        }
    }
    
    func setNavigation(){
        self.navigationController?.navigationBar.backgroundColor = AppColor.clear
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "star")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = AppColor.darkgrayColor.cgColor
        button.addTarget(self, action: #selector(self.handleButton), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        let buttonback = UIButton.init(type: .custom)
        buttonback.setImage(UIImage.init(named: "back-icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonback.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        buttonback.layer.borderWidth = 1
        buttonback.layer.cornerRadius = 10
        buttonback.layer.borderColor = AppColor.darkgrayColor.cgColor
        buttonback.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem  =  UIBarButtonItem(customView: buttonback)
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationItem.setLeftBarButton(nil, animated: false)
    }
    
    @objc func handleButton( sender : UIButton ) {
        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
        let userID = UserHelper.getUserIDFromUserDefaults()
        let restaurant = self.Restorunt_Detail
        if self.isFavourite == true {
            self.db.collection("\(AppFirebaseKey.users)/\(userID)/favourite").document("\(restaurant.restaurantId!)").delete()
        }else{
            self.db.collection("\(AppFirebaseKey.users)/\(userID)/favourite").document("\(restaurant.restaurantId!)").setData([:])
        }
        
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
