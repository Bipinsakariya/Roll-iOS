//
//  ReviewController.swift
//  Roll
//
//  Created by tagline13 on 30/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseFirestore

class ReviewController: UIViewController {
    
    
    @IBOutlet weak var viwe_main: UIView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var top_lbl_title: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_title: NSLayoutConstraint!
    @IBOutlet weak var traling_lbl_title: NSLayoutConstraint!
    
    @IBOutlet weak var view_rateing: CosmosView!
    @IBOutlet weak var top_view_rateing: NSLayoutConstraint!
    @IBOutlet weak var leading_view_rateing: NSLayoutConstraint!
    @IBOutlet weak var traling_view_rateing: NSLayoutConstraint!
    
    @IBOutlet weak var txt_review: UITextView!
    @IBOutlet weak var top_txt_review: NSLayoutConstraint!
    @IBOutlet weak var leading_txt_review: NSLayoutConstraint!
    @IBOutlet weak var traling_txt_review: NSLayoutConstraint!
    
    @IBOutlet weak var btn_finish: UIButton!
    @IBOutlet weak var top_btn_finish: NSLayoutConstraint!
    @IBOutlet weak var leading_btn_finish: NSLayoutConstraint!
    @IBOutlet weak var traling_btn_finish: NSLayoutConstraint!
    
    @IBOutlet weak var height_txt_review: NSLayoutConstraint!
    @IBOutlet weak var bottom_btn_finish: NSLayoutConstraint!
    @IBOutlet weak var height_btn_finish: NSLayoutConstraint!
    
    let db = Firestore.firestore()
    var ReviewData = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        setData()
        setLayout()
        setRatings()
    }
    
    func setFont(){
        self.lbl_title.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
        self.txt_review.font = AppFont.MuseoSansCyrl_500(fontSize: 18)
        self.btn_finish.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 15)
    }
    
    func setLayout(){
        self.lbl_title.textColor = AppColor.blackColor
        self.leading_lbl_title.constant = UIHelper.setAutoSize(size: 30)
        self.traling_lbl_title.constant = UIHelper.setAutoSize(size: 30)
        self.top_lbl_title.constant = UIHelper.setAutoSize(size: 111)
        self.top_view_rateing.constant = UIHelper.setAutoSize(size: 27)
        self.top_txt_review.constant = UIHelper.setAutoSize(size: 30)
        self.leading_txt_review.constant = UIHelper.setAutoSize(size: 42)
        self.traling_txt_review.constant = UIHelper.setAutoSize(size: 43)
        self.top_btn_finish.constant = UIHelper.setAutoSize(size: 118)
        self.leading_btn_finish.constant = UIHelper.setAutoSize(size: 37)
        self.traling_btn_finish.constant = UIHelper.setAutoSize(size: 38)
        self.height_txt_review.constant = UIHelper.setAutoSize(size: 197)
        self.bottom_btn_finish.constant = UIHelper.setAutoSize(size: 50)
        self.height_btn_finish.constant = UIHelper.setAutoSize(size: 64)
        self.btn_finish.layer.borderWidth = 2
        self.btn_finish.layer.borderColor = AppColor.blueColor.cgColor
        self.btn_finish.titleLabel?.tintColor = AppColor.blueColor
        UIHelper.courner_View(globeView: btn_finish, redius: UIHelper.setAutoSize(size: 20))
        UIHelper.courner_View(globeView: txt_review, redius: UIHelper.setAutoSize(size: 10))
        UIHelper.shadow_View(globeView: self.txt_review!)
        self.txt_review.textContainerInset = UIEdgeInsets(top: UIHelper.setAutoSize(size: 30), left: UIHelper.setAutoSize(size: 30), bottom: UIHelper.setAutoSize(size: 30), right: UIHelper.setAutoSize(size: 30))
        
    }
    
    func setData(){
        self.lbl_title.text = AppString.rateyourexperience
        self.btn_finish.setTitle(AppButtons.finish, for: .normal)
        
    }
    
    func setRatings(){
        self.view_rateing.settings.filledColor = AppColor.blueColor
        self.view_rateing.settings.emptyColor = AppColor.lightgrayColor
        self.view_rateing.settings.starSize = 56
        self.view_rateing.settings.totalStars = 5
        self.view_rateing.settings.fillMode = .precise
        self.view_rateing.settings.starMargin = 0
        self.view_rateing.settings.emptyBorderWidth = 0
    }
    
    @IBAction func btn_finish_tapped(_ sender: Any) {
        self.db.collection(AppFirebaseKey.restaurants)
            .getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for i in snapshot!.documents {
                        if i.documentID == "restaurant_RN5GAUOCRvdyWSEO9OLkHLFhodv1" {
                            let data_result = i.data() as NSDictionary
                            let restaurants_details = data_result
                            if restaurants_details.value(forKey: "review") == nil {
                                self.ReviewData = []
                            }else{
                                self.ReviewData = (restaurants_details.value(forKey: "review") as! NSMutableArray)
                            }
                            
                            let user :[String : Any] = [ "Message" : self.txt_review.text! , "Rating" : self.view_rateing.rating, "UserID" : UserHelper.getUserIDFromUserDefaults()]
                            print(self.ReviewData)
                            self.ReviewData.add(user)
                            self.db.collection(AppFirebaseKey.restaurants).document("restaurant_RN5GAUOCRvdyWSEO9OLkHLFhodv1").updateData(["review" : self.ReviewData])
                           
                            return
                        }

                    }

                }

        }
        
        
    }
}

