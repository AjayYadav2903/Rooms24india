//
//  RatingVC.swift
//  Rooms24india
//
//  Created by admin on 04/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RatingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnActionClose(_ sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
          self.navigationController?.pushViewController(loginStoryBoard, animated: true)
    }
    
    @IBAction func btnActionRatingsSubmit(_ sender: UIButton) {
          let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)

      }
}
