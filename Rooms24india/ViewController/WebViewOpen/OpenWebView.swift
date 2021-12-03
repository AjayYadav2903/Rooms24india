//
//  OpenWebView.swift
//  Rooms24india
//
//  Created by admin on 22/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import WebKit

class OpenWebView: UIViewController {
    
    var urlString : String!
    
    @IBOutlet weak var webView : UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if urlString != nil {
            let url = URL(string: urlString)
            webView.loadRequest(NSURLRequest(url: url!) as URLRequest)
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
