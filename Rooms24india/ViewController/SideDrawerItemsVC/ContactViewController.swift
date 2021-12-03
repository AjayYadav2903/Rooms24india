//
//  ContactViewController.swift
//  AirVting
//
//  Created by SeiLK on 10/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import KRProgressHUD
class ContactViewController: Rooms24BaseVC, UITextViewDelegate {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        descriptionTextView.delegate = self
    }

    @IBAction func tapBackButton(_ sender: Any) {
       toggleLeftSlide()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionLabel.isHidden = descriptionTextView.text.count > 0
    }
    
    func toggleLeftSlide(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }

    @IBAction func tapSendButton(_ sender: Any) {
        //TODO: Handle send contact form
        let name: String = nameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email: String = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let message: String = descriptionTextView.text
        if !self.validateName(str: name) {return}
        if !self.validateEmail(str: email, strTitle: "Contact Us".uppercased()) {return}
        if !self.validateMessage(str: message){return}
        let param = ["name": name, "email": email, "message": message]
        WebServices.postRequest(urlApiString: Constants.Network.contact, paramters: param as [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let _ = self else {return}
            if status == true{
                let msg = "Thank you! Your message has been sent successfully."
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: msg, strTitle: "Contact Us".uppercased(), acceptBlock: {
                        self?.dismiss(animated: true, completion: nil)
                    })
                })
            }
           
        }
    }
    
    func validateMessage(str:String) -> Bool{
        if str == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please input message", strTitle: "Contact Us".uppercased(), acceptBlock: nil, rejectBlock: nil)
            return false
        }
        return true
    }
    
    func validateName(str:String) -> Bool {
        if str == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please input name", strTitle: "Contact Us".uppercased(), acceptBlock: nil, rejectBlock: nil)
            return false
        }
        return true
    }
    
    func validateEmail(str:String,strTitle:String) -> Bool {
        if str == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please input email", strTitle: strTitle, acceptBlock: nil, rejectBlock: nil)
            return false
        } else {
            if Utils.isValidEmail(Emailid: str) {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Email is invalid!", strTitle: strTitle, acceptBlock: nil, rejectBlock: nil)
                return false
            }
        }
    }
}
