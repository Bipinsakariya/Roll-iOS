//
//  ViewMenuController.swift
//  Roll
//
//  Created by tagline13 on 04/07/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import WebKit

class ViewMenuController: UIViewController , WKUIDelegate {

    @IBOutlet weak var view_main: UIView!
    var webView: WKWebView!
    var menulink : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(menulink!)
        
        let url = URL(string: (menulink!))
        webView.load(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.uiDelegate = self
        view = webView
    }
    
}
