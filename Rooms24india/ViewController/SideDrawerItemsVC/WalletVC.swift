//
//  WalletVC.swift
//  Rooms24india
//
//  Created by admin on 24/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class WalletVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
          toggleLeftSlide()
       }
    
       
       func toggleLeftSlide(){
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
       }
}
