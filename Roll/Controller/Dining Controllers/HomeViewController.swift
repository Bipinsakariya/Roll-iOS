//
//  HomeViewController.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import CoreLocation
import UserNotifications
import Presentr


class HomeViewController:  BaseViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CLLocationManagerDelegate{
    
    
    //MARK:- Outlets and Variables
    @IBOutlet weak var height_viewMain: NSLayoutConstraint!
    @IBOutlet weak var lbl_checkin: UILabel!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var collection_rasturant: UICollectionView!
    @IBOutlet weak var collection_favourite: UICollectionView!
    @IBOutlet weak var lbl_favourite: UILabel!
    @IBOutlet weak var lbl_nearby: UILabel!
    @IBOutlet weak var top_lbl_ckeckin: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_checkin: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_checkin: NSLayoutConstraint!
    @IBOutlet weak var height_view_search: NSLayoutConstraint!
    @IBOutlet weak var leading_txt_search: NSLayoutConstraint!
    @IBOutlet weak var bottom_txt_search: NSLayoutConstraint!
    @IBOutlet weak var top_txt_search: NSLayoutConstraint!
    @IBOutlet weak var top_view_search: NSLayoutConstraint!
    @IBOutlet weak var view_favourite: UIView!
    @IBOutlet weak var top_view_favourite: NSLayoutConstraint!
    @IBOutlet weak var leading_view_favourite: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_favourite: NSLayoutConstraint!
    @IBOutlet weak var height_view_favourite: NSLayoutConstraint!
    @IBOutlet weak var top_collection_favourite: NSLayoutConstraint!
    @IBOutlet weak var view_resturants: UIView!
    @IBOutlet weak var top_view_resturants: NSLayoutConstraint!
    @IBOutlet weak var leading_view_restaurants: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_restaurants: NSLayoutConstraint!
    @IBOutlet weak var top_collection_restaurant: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_leading: NSLayoutConstraint!
    @IBOutlet weak var leading_view_search: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_search: NSLayoutConstraint!
    //MARK: -VARIABLES
    
    var RestoruntData = Array<RestaurantsData>()
    var sortedRestaurants = Array<RestaurantsData>()
    var searchRestaurants = Array<RestaurantsData>()
    var test_data = NSDictionary()
    var db = Firestore.firestore()
    var locationManager : CLLocationManager = CLLocationManager()
    var origional_height = CGFloat()
    var FavouriteRestoruntData = Array<RestaurantsData>()
    
    let ENTERED_REGION_MESSAGE = "Welcome to Playa Grande! If the waves are good, you can try surfing!"
    let ENTERED_REGION_NOTIFICATION_ID = "EnteredRegionNotification"
    let EXITED_REGION_MESSAGE = "Bye! Hope you had a great day at the beach!"
    let EXITED_REGION_NOTIFICATION_ID = "ExitedRegionNotification"
    
    //MARK:- ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        self.collection_favourite.tag = 0
        self.collection_rasturant.tag = 1
        
        let nib = UINib(nibName: "RestaurantsViewCell", bundle: nil)
        collection_rasturant.register(nib, forCellWithReuseIdentifier: "RestaurantsViewCell")
        let nib1 = UINib(nibName: "FavouriteViewCell", bundle: nil)
        collection_favourite.register(nib1, forCellWithReuseIdentifier: "FavouriteViewCell")
        
        self.txt_search.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.origional_height = height_viewMain.constant - self.collection_rasturant.bounds.height - self.height_view_favourite.constant
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        setFont()
        setLayout()
        setData()
        determineMyCurrentLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:- Custom Functions
    
    func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = AppColor.clear
        var image = UIImage()
        image = UIImage.init(named: "drawer")!
        let BackButton = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem  = BackButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        var Appicon = UIImage()
        Appicon = UIImage.init(named: "roll")!
        let imageView = UIImageView(image: Appicon.withRenderingMode(.alwaysOriginal))
        imageView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
        let item = UIBarButtonItem(customView: imageView)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func setFont(){
        self.lbl_checkin.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
        self.txt_search.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.lbl_nearby.font = AppFont.MuseoSansCyrl_500(fontSize: 20)
        self.lbl_favourite.font = AppFont.MuseoSansCyrl_500(fontSize: 16)
    }
    
    func setLayout(){
        
        self.top_lbl_ckeckin.constant = UIHelper.setAutoSize(size: 30)
        self.leading_lbl_checkin.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_lbl_checkin.constant = UIHelper.setAutoSize(size: 30)
        self.top_view_search.constant = UIHelper.setAutoSize(size: 10)
        self.leading_view_search.constant = UIHelper.setAutoSize(size: 30)
        self.trailing_view_search.constant = UIHelper.setAutoSize(size: 30)
        self.top_txt_search.constant = UIHelper.setAutoSize(size: 8)
        self.bottom_txt_search.constant = UIHelper.setAutoSize(size: 8)
        self.leading_txt_search.constant = UIHelper.setAutoSize(size: 0)
        self.height_view_search.constant = UIHelper.setAutoSize(size: 50)
        
        self.trailing_view_favourite.constant = UIHelper.setAutoSize(size: 30)
        self.leading_view_favourite.constant = UIHelper.setAutoSize(size: 30)
        
        self.top_collection_favourite.constant = UIHelper.setAutoSize(size: 20)
        self.top_view_resturants.constant = UIHelper.setAutoSize(size: 18)
        self.trailing_view_restaurants.constant = UIHelper.setAutoSize(size: 0)
        self.leading_view_restaurants.constant = UIHelper.setAutoSize(size: 0)
        self.leading_lbl_leading.constant = UIHelper.setAutoSize(size: 30)
        self.top_collection_restaurant.constant = UIHelper.setAutoSize(size: 20)
        
        
        self.lbl_nearby.textColor = AppColor.blueColor
        if self.FavouriteRestoruntData.count == 0 {
            self.height_view_favourite.constant = 0
            self.top_view_favourite.constant = UIHelper.setAutoSize(size: 10)
        }else{
            self.height_view_favourite.constant = UIHelper.setAutoSize(size: 230)
            self.top_view_favourite.constant = UIHelper.setAutoSize(size: 40)
        }
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    func setData(){
        self.lbl_checkin.text = AppString.checkin
        self.txt_search.placeholder = AppPlaceHolders.search
        self.lbl_favourite.text = AppString.favourite
        self.lbl_nearby.text = AppString.nearBy
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("123")
        let seachText = self.txt_search.text!
        print(seachText)
        if seachText == ""{
            self.sortedRestaurants =  self.RestoruntData
        }else{
            let filterByLocation = self.RestoruntData.filter({ ($0.businessName?.contains(self.txt_search.text!))! })
            sortedRestaurants.removeAll()
            for item in filterByLocation{
                self.sortedRestaurants.append(item)
            }
        }
        self.collection_rasturant.reloadData()
    }
    
    
    //MARK:- Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return self.FavouriteRestoruntData.count
        }else{
            return self.sortedRestaurants.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteViewCell", for: indexPath) as? FavouriteViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            // let restaurant = sortedRestaurants[indexPath.row] as! RestaurantsData
            let restaurant = FavouriteRestoruntData[indexPath.row]
            cell.cell_name.text = restaurant.businessName
            cell.cell_image.sd_setImage(with: URL(string:restaurant.businessPhotoUrl! ), placeholderImage: UIImage(named: "placeholder.png"))
            UIHelper.shadow_View(globeView: cell)
            UIHelper.courner_View(globeView: cell, redius: UIHelper.setAutoSize(size: 25))
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsViewCell", for: indexPath) as? RestaurantsViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            let restaurant = sortedRestaurants[indexPath.row] as! RestaurantsData
            //            let restaurant = RestoruntData[indexPath.row]
            cell.cell_name.text = restaurant.businessName
            cell.cell_description.text = restaurant.businessDescription
            cell.cell_button.tag = indexPath.row
            cell.cell_button.addTarget(self, action: #selector(CheckIn_button_tapped), for: .touchUpInside)
            cell.btn_viewmenu.tag = indexPath.row
            cell.btn_viewmenu.addTarget(self, action: #selector(viewMenu_button_tapped), for: .touchUpInside)
            cell.cell_image.sd_setImage(with: URL(string:restaurant.businessPhotoUrl! ), placeholderImage: UIImage(named: "placeholder.png"))
            UIHelper.courner_View(globeView: cell.cell_image, redius: UIHelper.setAutoSize(size: 20))
            UIHelper.courner_View(globeView: cell.cell_bottomView, redius: UIHelper.setAutoSize(size: 20))
            UIHelper.courner_View(globeView: cell.cell_view, redius: UIHelper.setAutoSize(size: 20))
            UIHelper.shadow_View(globeView: cell)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            do {
                let docId = self.db.collection(AppFirebaseKey.orders).document().documentID
                let vc = Storyboards.DiningView.instantiateViewController(identifier: "StatusViewController") as! StatusViewController
                // let Restorunt_data = sortedRestaurants[sender!.tag]
                let Restorunt_data = self.FavouriteRestoruntData[indexPath.row]
                let restoruntData = Restorunt_data
                vc.Restorunt_Detail = restoruntData
                vc.isFavourite = true
                let order = AppOrderKeys.sendOrderDetails( restaurantId: restoruntData.restaurantId!, businessName: restoruntData.businessName!, createdAt: "\(Date())", grandTotal: 0, promoCode: 0, status: AppOrderStatusKeys.justarrived, subTotal: 0, tableNumber: 0, taxAmount: 0, updatedAt: "\(Date())", userId: UserHelper.getUserIDFromUserDefaults(), items: [], server: [])
                self.db.collection(AppFirebaseKey.orders).document(docId).setData(order)
                vc.orderID = docId
                AppStatus.status = AppOrderStatusKeys.justarrived
                self.navigationController?.pushViewController(vc, animated: true)
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
        }else{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell_height = Double(UIHelper.setAutoSize(size: 206 + 35)) * Double(self.sortedRestaurants.count)
        self.height_viewMain.constant =  self.origional_height + CGFloat(cell_height) + self.height_view_favourite.constant
        
                   
        if collectionView.tag == 0 {
            return CGSize(width: UIHelper.setAutoSize(size: 100), height: UIHelper.setAutoSize(size: 145))
        }else{
            return CGSize(width: collectionView.bounds.width - UIHelper.setAutoSize(size: 60), height: UIHelper.setAutoSize(size: 206))
        }
    }
    
    @objc func CheckIn_button_tapped(_ sender: UIButton?) {
        do {
            let docId = self.db.collection(AppFirebaseKey.orders).document().documentID
            let vc = Storyboards.DiningView.instantiateViewController(identifier: "StatusViewController") as! StatusViewController
            // let Restorunt_data = sortedRestaurants[sender!.tag]
            let Restorunt_data = RestoruntData[sender!.tag]
            let restoruntData = Restorunt_data
            vc.Restorunt_Detail = restoruntData
            let order = AppOrderKeys.sendOrderDetails( restaurantId: restoruntData.restaurantId!, businessName: restoruntData.businessName!, createdAt: "\(Date())", grandTotal: 0, promoCode: 0, status: AppOrderStatusKeys.justarrived, subTotal: 0, tableNumber: 0, taxAmount: 0, updatedAt: "\(Date())", userId: UserHelper.getUserIDFromUserDefaults(), items: [], server: [])
            self.db.collection(AppFirebaseKey.orders).document(docId).setData(order)
            vc.orderID = docId
            AppStatus.status = AppOrderStatusKeys.justarrived
            self.navigationController?.pushViewController(vc, animated: true)
//            self.db.collection(AppFirebaseKey.orders).document(docId).setData(["order" : "SHIVAM"])
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        
    }
    
    @objc func viewMenu_button_tapped(_ sender : UIButton?){
        let vc = Storyboards.DiningView.instantiateViewController(identifier: "ViewMenuController") as! ViewMenuController
        let presenter1: Presentr = {
            let width = ModalSize.full
            let height = ModalSize.default
            let customType = PresentationType.custom(width: width, height: height, center: .bottomCenter)
            let customPresenter = Presentr(presentationType : customType)
            customPresenter.roundCorners = true
            customPresenter.backgroundOpacity = 0.5
            customPresenter.cornerRadius = 50
            
            return customPresenter
        }()
        let Restorunt_data = RestoruntData[sender!.tag]
        vc.menulink = Restorunt_data.menuLink ?? "www.google.com"
        if Restorunt_data.menuLink != "" {
            customPresentViewController(presenter1, viewController: vc, animated: true, completion: nil)
        }
        
    }
    
    //MARK:- Methods for location
    
    func determineMyCurrentLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
        
        db.collection(AppFirebaseKey.restaurants)
            .addSnapshotListener { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.RestoruntData.removeAll()
                    for i in snapshot!.documents {
                        let data_result = i.data() as NSDictionary
                        let restaurants_details = data_result
                        let r_data : RestaurantsData = RestaurantsData()
                        let geoLocation = restaurants_details.value(forKey: "geoLocation")
                        print("R_DATA  \(restaurants_details)")
                        r_data.restaurantId = (restaurants_details.value(forKey: "restaurantId") as? String)
                        r_data.address = (restaurants_details.value(forKey: "address") as? String)
                        r_data.businessName = (restaurants_details.value(forKey: "businessName") as? String)
                        r_data.businessDescription = (restaurants_details.value(forKey: "description") as? String)
                        r_data.businessPhotoUrl = (restaurants_details.value(forKey: "businessPhotoUrl") as? String)
                        r_data.longitude = ((geoLocation as AnyObject).value(forKey: "longitude") as? Double)
                        r_data.latitude = ((geoLocation as AnyObject).value(forKey: "latitude") as? Double)
                        r_data.radius = ((geoLocation as AnyObject).value(forKey: "radius") as? Int)
                        r_data.menuLink = (restaurants_details.value(forKey: "menuLink") as? String)
                        self.RestoruntData.append(r_data)
                    }
                    self.favourite()
                    self.collection_favourite.reloadData()
                    self.collection_rasturant.reloadData()
                    
                }
                
                let ary : [RestaurantsData] = self.RestoruntData
                for mdl in ary {
                    print("... \( mdl.restaurantId!)")
                    let region = self.region(withGeotification: CLLocationCoordinate2D(latitude: (mdl.latitude) ?? 0.00, longitude: (mdl.longitude) ?? 0.00), radius: CLLocationDistance(500),identifier: "\(mdl.restaurantId!)", entry: true, data: mdl)
                    self.locationManager.startMonitoring(for: region)
                    
                }
                
        }
        
    }
    
    func region(withGeotification coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, entry: Bool , data : RestaurantsData) -> CLCircularRegion {
        let region = CLCircularRegion(center: coordinate, radius: radius, identifier: identifier)
        region.notifyOnEntry = entry
        region.notifyOnExit = entry
        return region
    }
    
    
    func EnterCase(id : String?){
        let filterByLocation = self.RestoruntData.filter() { $0.restaurantId == id }
        for item in filterByLocation{
            self.sortedRestaurants.append(item)
        }
        self.collection_rasturant.reloadData()
    }
    
    func ExitCase(id : String?){
        for item in sortedRestaurants{
            if item.restaurantId == id {
                self.sortedRestaurants.removeAll(keepingCapacity: item.restaurantId == id)
            }
        }
        self.collection_rasturant.reloadData()
    }
    
    //MARK:-Location manage delegate method:
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("The monitored regions are: \(manager.monitoredRegions)")
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations update...")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.EnterCase(id: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.ExitCase(id: region.identifier)
    }
    
    
    //MARK:- favourite module
    
    func favourite() {
        db.collection("\(AppFirebaseKey.users)/\(UserHelper.getUserIDFromUserDefaults())/favourite")
            .addSnapshotListener { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.FavouriteRestoruntData.removeAll()
                    for i in snapshot!.documents {
                        print("DATA :::::::::: \(i.documentID)")
                        let filterByLocation = self.RestoruntData.filter() { $0.restaurantId == i.documentID }
                        for item in filterByLocation{
                            self.FavouriteRestoruntData.append(item)
                            print(self.FavouriteRestoruntData.count)
                        }
                        self.collection_favourite.reloadData()
                    }
                    
                }
        }
    }
}



