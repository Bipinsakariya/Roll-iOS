//
//  BaseViewController.swift
//  Roll
//
//  Created by tagline13 on 26/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SlideMenuDelegate {
    @objc var isOpen = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         self.isOpen = !self.isOpen
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \(index)\n ", terminator: "")
        switch(index){
        case 0:
            self.openSameViewControllerBasedOnIdentifier("HomeViewController")
            break
        case 1:
            self.openViewControllerBasedOnIdentifier("OrderHistoryController")
            break
        case 2:
            self.openViewControllerBasedOnIdentifier("SettingsViewController")
            break
        default:
            print("default\n", terminator: "")
        }
          self.isOpen = !self.isOpen
        self.view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = Storyboards.ProfileView.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
                        self.navigationController!.pushViewController(destViewController, animated: true)
        }
         self.isOpen = !self.isOpen
        self.view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    func openSameViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let sameViewController : UIViewController = Storyboards.DiningView.instantiateViewController(identifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == sameViewController.restorationIdentifier!){
            print("Same VC")
        }
         self.isOpen = !self.isOpen
        self.view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        print(self.isOpen)
        sender.isEnabled = false
        sender.tag = 10
        
//        let menuVC  = Storyboards.DiningView.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let menuVC = Storyboards.DiningView.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.isOpen = !self.isOpen
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
}
