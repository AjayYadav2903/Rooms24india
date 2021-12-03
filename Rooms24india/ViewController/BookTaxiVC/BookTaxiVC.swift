//
//  BookTaxiVC.swift
//  Rooms24india
//
//  Created by admin on 22/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class BookTaxiVC: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var lblContact : UITextView!
    @IBOutlet weak var lblDescription : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblContact.toolbarPlaceholder = "Description"
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblDescription.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            lblDescription.isHidden = false
        }
    }
 
    
    @IBAction func btnBookNow(_ sender: Any) {
        self.lblDescription.endEditing(true)
        if lblContact.text != "" {
            Utils.showAlert(title: "", msg: "Thank You for your suggestion", selfObj: self) {
               _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
