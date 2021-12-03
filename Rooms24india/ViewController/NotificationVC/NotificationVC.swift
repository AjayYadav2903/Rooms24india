//
//  NotificationVC.swift
//  VSSHR
//
//  Created by admin on 18/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var tblNotification : UITableView!
    var arrPlanedLeaves = ["a","b","c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    @IBAction func btnActionDrawer(_ sender: UIButton) {
        toggleLeftSlide()
    }
    
    
    func toggleLeftSlide(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
}

extension NotificationVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlanedLeaves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNotification.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)  as! NotificationCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
