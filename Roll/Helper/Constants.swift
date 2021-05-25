//
//  Constants.swift
//  Roll
//
//  Created by tagline13 on 22/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import UIKit


typealias KeyValue  =  [String : Any]

struct AppKeys {
//    static let stripePublishableKey = "pk_test_0LRuk6sPmGOkyWHdK7OCrX0A00vvLi2gEI"  //client
    static let stripePublishableKey = "pk_test_I0UBegE9iZ9y3ZSmGnJD4Y0p000Yv6T87m"  // testing account
    static let stripeSerateKey = "sk_test_GiI8oGCSIm9hCUQ4VKYO60vG00TDDpue92"  //testing account
}

struct AppUrls {
    static let domain = "https://us-central1-tabz-dc096.cloudfunctions.net/api/customers/"
    static let addCard = "\(AppUrls.domain)add_card"
    static let getCards = "\(AppUrls.domain)cards/list"
    static let addFirstCArd = "\(AppUrls.domain)card_token"
}

struct AppColor {
//    static let shadowColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
//    static let lightBackgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
//    static let blackColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
//    static let whiteColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
//    static let buttonColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    static let lightgrayColor = UIColor(red: 211, green: 211, blue: 211, alpha: 1.0)
    static let clear = UIColor.clear
    static let whiteColor =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    static let lightgrayColor = UIColor(red: 245/255, green: 245/255, blue: 247/255, alpha: 1.0)
    static let darkgrayColor = UIColor(red: 0.553, green: 0.553, blue: 0.553, alpha: 1)
    static let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    static let redColor = UIColor(red: 255/255, green: 89/255, blue: 89/255, alpha: 1.0)
    static let blueColor = UIColor(red: 67/255, green: 166/255, blue: 255/255, alpha: 1.0)
    static let greenColor = UIColor(red: 74/255, green: 240/255, blue: 143/255, alpha: 1.0)
    static let testfieldTitleColor =  UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 0.69)
    static let SubTitleColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.69)
}

struct AppString {

    static let cardNumber = "Card Number"
    static let expirationDate = "Expiration Date"
    static let cvv = "CVV"
    static let cvvNumber = "CVV Number"
    static let expDateFormate = "MM/YY"
    static let checkinDesc = "Please let your server know you`ve check-in on Tabz, under DHILLON"
    static let RequesrDesc = "We will notify you when your server has closed out."
    static let rateyourexperience = "Rate your experience"
    static let receipt = "Receipt"
    static let fess = "taxes & fees"
    static let tip = "tip"
    static let subtotal = "subtotal"
    static let discount = "discount"
    static let totalbill = "total"
    static let server = "Server :"
    static let addATip = "Add A Tip!"
    static let createAcount = "Create Account"
    static let editAccount = "Edit profile"
    static let enterPhonenumber = "Enter mobile number"
    static let phoneDescription = "We'll text you a 6 code to verify your phone"
    static let enterOtp = "Enter the code sent to you"
    static let checkin = "Check In"
    static let orderHistory = "Order History"
    static let setting = "Settings"
    static let notification = "Notifications"
    static let pushnotification = "Push Notifications"
    static let terms = "Terms of Service"
    static let policy = "Privacy Policy"
    static let sendgift = "Send a gift card"
    static let home = "Home"
    static let diningHistory = "Dining history"
    static let addCard = "Add Card"
    static let age = "Date of Birth"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let email = "Email"
    static let addPaymentMethod = "Add Payment Method"
    static let favourite = "Your favorite restaurants"
    static let nearBy = "Restaurants near you"
}

struct AppPlaceHolders {
    static let enterPromocode = "Enter Promo Code..."
    static let firstName = "Shawn"
    static let lastName = "Dhillon"
    static let email = "shawn@pornhub.com"
    static let search = "Search Restaurants Nearby..."
}

struct AppButtons {
    static let submit = "Submit"
    static let createAccount = "Create Account"
    static let getStarted = "Get Started"
    static let Continue = "CONTINUE"
    static let checkIn = "Check In"
    static let splitbill = "Split Bill"
    static let requestCheckOut = "Request Check-Out"
    static let save = "Save"
    static let signOut = "Sign Out"
    static let placeOrder = "Place on Order"
    static let resend = "RESEND CODE"
    static let cencle = "Cancel"
    static let editProfile = "edit profile"
    static let finish = "FINISH"
    static let reportIssue = "REPORT AN ISSUE"
    static let seeDetails = "See details"
    static let done = "DONE"
    
    static let debit = "Debit"
    static let credit = "Credit"
    static let applePay = "Apple Pay"
    static let addCard = "Add card"
    
    static let readyForLeave = "ready to leave?"
    static let viewmenu = "VIEW MENU"
    static let checkout = "CHECK OUT"
}

struct AppUserKey {
    static let userId = "userID"
    static let userAccessToken = "userAccessToken"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let age = "age"
    static let email = "email"
    static let phone = "phone"
    static let profilePictureUrl = "profilePictureUrl"
    static let squareCustomerId = "squareCustomerId"
    static let userType = "userType"
    static let DeviceToken = "DeviceToken"
    static let stripeID = "userStripeId"
}

struct AppFirebaseKey {
    static let users = "users"
    static let restaurants = "restaurants"
    static let orderstest = "order test"
    static let orders = "orders"
}

struct AppOrderStatusKeys {
    static let checkin = "checked-in"
    static let checkout = "check-out"
    static let justarrived = "just-arrived"
    static let checkmeout = "check-me-out"
}

struct Storyboards {
    static let main                     = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    static let AuthenticationView       = UIStoryboard.init(name: "Authentication", bundle: Bundle.main)
    static let DiningView               = UIStoryboard.init(name: "Dining", bundle: Bundle.main)
    static let ProfileView              = UIStoryboard.init(name: "Profile", bundle: Bundle.main)
}

struct AppFont {
    static let Lato_Bold = "Lato-Bold"
    static let Lato_Reguler = "Lato-Regular"

    static func MuseoSansCyrl_500(fontSize: CGFloat) -> UIFont {
       return UIFont(name:self.Lato_Reguler , size: UIHelper.setAutoSize(size: fontSize))!
    }
   
    static func MuseoSansCyrl_700(fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: self.Lato_Bold, size: UIHelper.setAutoSize(size: fontSize))!
    }
}

struct Device {
    static let height = UIScreen.main.bounds.size.height
    static let width = UIScreen.main.bounds.size.width
    static let statusHeight = UIApplication.shared.statusBarFrame.size.height
    
}

struct AppStatusKey {
    static var is_Requested = false
    static var Current_OrderID = ""
 }

struct AppStatus {
    static var status = "just-arrived"
}
