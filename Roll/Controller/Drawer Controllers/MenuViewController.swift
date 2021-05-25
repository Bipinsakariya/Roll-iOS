//
//  MenuViewController.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
import SwiftSpinner

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @IBOutlet weak var lbl_userName: UILabel!
    
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var btn_signOut: UIButton!
    @IBOutlet var tblMenuOptions : UITableView!
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    @IBOutlet weak var btn_editProfile: UIButton!
    
    @IBOutlet weak var trailing_view_main: NSLayoutConstraint!
    @IBOutlet weak var top_tableview: NSLayoutConstraint!
    @IBOutlet weak var leading_tableview: NSLayoutConstraint!
    @IBOutlet weak var height_btn_signout: NSLayoutConstraint!
    
    @IBOutlet weak var top_view_profile: NSLayoutConstraint!
    @IBOutlet weak var leading_view_profile: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_profile: NSLayoutConstraint!
    @IBOutlet weak var height_view_profile: NSLayoutConstraint!
    @IBOutlet weak var top_img_user: NSLayoutConstraint!
    @IBOutlet weak var bottom_img_user: NSLayoutConstraint!
    @IBOutlet weak var trailing_lbl_name: NSLayoutConstraint!
    @IBOutlet weak var leading_lbl_name: NSLayoutConstraint!
    @IBOutlet weak var top_lbl_name: NSLayoutConstraint!
    
    @IBOutlet weak var leading_btn_edit: NSLayoutConstraint!
    @IBOutlet weak var trailing_btn_edit: NSLayoutConstraint!
    @IBOutlet weak var top_btn_edit: NSLayoutConstraint!
    
    @IBOutlet weak var leading_view_name: NSLayoutConstraint!
    @IBOutlet weak var bottom_view_name: NSLayoutConstraint!
    @IBOutlet weak var trailing_view_name: NSLayoutConstraint!
    
    @IBOutlet weak var top_view_name: NSLayoutConstraint!
    
    @IBOutlet weak var btn_camera: UIButton!
    @IBOutlet weak var heigth_btn_img_update: NSLayoutConstraint!
    
    var arrayMenuOptions = [Dictionary<String,String>]()
    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
    var imagePicker = UIImagePickerController()
    var db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetFont()
        updateArrayMenuOptions()
        tblMenuOptions.tableFooterView = UIView()
        setData()
    }
    
    override func viewWillLayoutSubviews() {
        setLayout()
    }
    
    func SetFont(){
        lbl_userName.font = AppFont.MuseoSansCyrl_700(fontSize: 25)
        btn_signOut.setTitle(AppButtons.signOut, for: .normal)
        btn_signOut.backgroundColor = AppColor.blackColor
        btn_editProfile.setTitle(AppButtons.editProfile, for: .normal)
        btn_editProfile.titleLabel?.textColor = AppColor.redColor
        btn_editProfile.titleLabel?.textAlignment = .left
        btn_editProfile.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
        btn_signOut.titleLabel?.font = AppFont.MuseoSansCyrl_700(fontSize: 25)
        btn_signOut.titleLabel?.textColor = UIColor.white
        UIHelper.courner_View(globeView: img_user, redius: 20)
    }
    
    func setLayout(){
        self.trailing_view_main.constant = UIHelper.setAutoSize(size: 60)
        self.top_tableview.constant = UIHelper.setAutoSize(size: 40)
        self.leading_tableview.constant = UIHelper.setAutoSize(size: 30)
        self.height_btn_signout.constant = UIHelper.setAutoSize(size: 70)
        self.leading_view_profile.constant = UIHelper.setAutoSize(size: 30)
        self.height_view_profile.constant = UIHelper.setAutoSize(size: 110)
        self.trailing_view_profile.constant = UIHelper.setAutoSize(size: 0)
        self.top_img_user.constant = UIHelper.setAutoSize(size: 10)
        self.bottom_img_user.constant = UIHelper.setAutoSize(size: 10)
        self.trailing_lbl_name.constant = UIHelper.setAutoSize(size: 30)
        self.top_view_profile.constant = UIHelper.setAutoSize(size: 100)
        self.top_lbl_name.constant = UIHelper.setAutoSize(size: 5)
        self.leading_btn_edit.constant = UIHelper.setAutoSize(size: 10)
        self.trailing_btn_edit.constant = UIHelper.setAutoSize(size: 10)
        self.top_btn_edit.constant = UIHelper.setAutoSize(size: 3)
        
        self.top_view_name.constant = UIHelper.setAutoSize(size: 5)
        self.leading_view_name.constant = UIHelper.setAutoSize(size: 10)
        self.trailing_view_name.constant = UIHelper.setAutoSize(size: 5)
        self.bottom_view_name.constant = UIHelper.setAutoSize(size: 5)
        self.heigth_btn_img_update.constant = UIHelper.setAutoSize(size: 40)
        
        btn_camera.roundCorners([ .bottomRight], radius:  self.heigth_btn_img_update.constant/2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setData(){
        let userDetails = UserHelper.getUserDetails()
        let username = "\(userDetails.value(forKey: AppUserKey.firstName)!) \(userDetails.value(forKey: AppUserKey.lastName)!)"
        self.img_user.sd_setImage(with: URL(string:userDetails.value(forKey: AppUserKey.profilePictureUrl) as! String ), placeholderImage: UIImage(named: "user-placeholder.png"))
//        let username = "Shawn dhillion"
//        self.img_user.image = UIImage.init(named: "server")
        
        self.lbl_userName.text = username
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":AppString.home, "icon":"home"])
        arrayMenuOptions.append(["title":AppString.diningHistory, "icon":"orderhistory"])
        arrayMenuOptions.append(["title":AppString.setting, "icon":"setting"])
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        
        
        lblTitle.font = AppFont.MuseoSansCyrl_700(fontSize: 22)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        imgIcon.image = UIImage.init(named: arrayMenuOptions[indexPath.row]["icon"]!)
//        cell.imageView?.image =
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    @IBAction func btn_signout_tapped(_ sender: Any) {
        UserHelper.logout()
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btn_editProfile_Tapped(_ sender: Any) {
        let vc = Storyboards.AuthenticationView.instantiateViewController(identifier: "CreateAccountViewController") as! CreateAccountViewController
        vc.isEditMode = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_update_img_tapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            print(image)
            self.img_user.image = image
            let storageRef = Storage.storage().reference().child("users/\(UserHelper.getUserIDFromUserDefaults()).png")
            SwiftSpinner.show("Saving your photo...")
            guard let imageData = self.img_user.image!.jpegData(compressionQuality: 0.75) else { return }
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            storageRef.putData(imageData, metadata: metaData) { metaData, error in
                if error == nil, metaData != nil {

                    storageRef.downloadURL { url, error in
                        print("UEL : \(url)")
                        do {
                            try self.db.collection(AppFirebaseKey.users).document( UserHelper.getUserIDFromUserDefaults()).updateData([AppUserKey.profilePictureUrl : "\(url!)"])
                            
                            self.db.collection(AppFirebaseKey.users).document(UserHelper.getUserIDFromUserDefaults())
                                   .addSnapshotListener { documentSnapshot, error in
                                       guard let document = documentSnapshot else {
                                           print("Error fetching document: \(error!)")
                                           return
                                       }
                                       let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                                       UserHelper.saveUserDetail(Details: document.data() as NSDictionary? ?? [:] as NSDictionary)
                                       print("\(source) data: \(document.data() ?? [:])")
                                   }
                            SwiftSpinner.hide()
                        } catch let error {
                            SwiftSpinner.show("Saving your photo...").addTapHandler({
                              SwiftSpinner.hide()
                            }, subtitle: error.localizedDescription)
                            print("Error writing city to Firestore: \(error)")
                        }
                    }
                }
            }
        }
        else{
            //
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
