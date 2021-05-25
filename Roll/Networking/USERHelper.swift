//
//  USERHelper.swift
//  Roll
//
//  Created by tagline13 on 22/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

class UserHelper {
    
    //MARK:- USER ID
    static func saveUserIDInUserDefaults(id: String) {
        UserDefaults.standard.set(id, forKey: AppUserKey.userId)
    }
   
    static func getUserIDFromUserDefaults() -> String {
        if (UserDefaults.standard.value(forKey: AppUserKey.userId) != nil) {
            return UserDefaults.standard.value(forKey: AppUserKey.userId) as! String
        } else {
            return ""
        }
    }
    
    //MARK:- USER ACCESS TOKEN
     static func saveUserAccessTokenInUserDefaults(token: String) {
         UserDefaults.standard.set(token, forKey: AppUserKey.userAccessToken)
     }
    
     static func getUserAccessTokenFromUserDefaults() -> String {
         if (UserDefaults.standard.value(forKey: AppUserKey.userAccessToken) != nil) {
             return UserDefaults.standard.value(forKey: AppUserKey.userAccessToken) as! String
         } else {
             return ""
         }
     }
    
    
    //MARK:- FCM DATA
    static func saveFCMInUserDefaults(token: String) {
        UserDefaults.standard.set(token, forKey: "FCM")
    }
    
    static func getFCMFromUserDefaults() -> String {
        if (UserDefaults.standard.value(forKey: "FCM") != nil) {
            return UserDefaults.standard.value(forKey: "FCM") as! String
        } else {
            return ""
        }
    }
    
    //MARK:- USER DETAILS
    static func saveUserDetail(Details : NSDictionary) {
        UserDefaults.standard.rm_setCustomObject(Details, forKey: "USER_DETAIL")
    }
    static func getUserDetails() -> NSDictionary {
        if (UserDefaults.standard.value(forKey: "USER_DETAIL") != nil) {
            return UserDefaults.standard.rm_customObject(forKey: "USER_DETAIL") as! NSDictionary
        }
        else{
            return NSDictionary()
        }
    }
    
    
    static func logout(){
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        let appDelegate = UIApplication.shared.delegate as? SceneDelegate
//        appDelegate!.window?.rootViewController = vc1
        let vc = Storyboards.DiningView.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
        vc.navigationController?.popToRootViewController(animated: true)
    }
    
}
