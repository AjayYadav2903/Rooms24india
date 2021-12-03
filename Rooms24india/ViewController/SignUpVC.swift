//
//  SignUpVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var txtFldName : UITextField!
    @IBOutlet weak var txtFldPassword : UITextField!
    @IBOutlet weak var txtFldEmail : UITextField!

    @IBOutlet weak var btnSignUp: UIButton!
    var accountType = "Customer"

    override func viewDidLoad() {
        super.viewDidLoad()
        accountType = Constant.accountType.Customer
        setUpUI()
    }
    
    func setUpUI()  {
        
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor.clear

           txtFldName.setIconOnTextFieldLeft(UIImage(named: "user")!)
           txtFldEmail.setIconOnTextFieldLeft(UIImage(named: "email")!)
           txtFldPassword.setIconOnTextFieldLeft(UIImage(named: "password")!)
           btnSignUp.cornerRadius = btnSignUp.frame.size.height/2
           Utils.changePlaceholderColor(txtFld: txtFldName, text: "Name")
           Utils.changePlaceholderColor(txtFld: txtFldEmail, text: "example@gmail.com")
           Utils.changePlaceholderColor(txtFld: txtFldPassword, text: "Password")
       }
    
    
    func validatePassword() -> Bool {
        if txtFldPassword.text == "" {
            Utils.showAlert(title: "", msg: "Please enter password!", selfObj: self) {
                
            }
            return false
        }
        else if self.txtFldPassword.text?.count ?? 0 < 8{
            Utils.showAlert(title: "", msg: "Password must be greater than 8 characters", selfObj: self) {
                
            }
            return false
        }else if !Utils.isValidPassword(Password: txtFldPassword.text) {
            Utils.showAlert(title: "", msg: "password must contain uppercase lowercase and number", selfObj: self) {
                
            }
          return false
            
        }
        return true
    }
    
    @IBAction func btnActionSignUp(_ sender: UIButton) {
        if txtFldName.text! == "" {
            Utils.showAlert(title: "", msg: "Please enter your name", selfObj: self) {
                
            }
            return
        }
        
        if Utils.isValidEmail(Emailid: txtFldEmail.text!) {
          
            if !validatePassword() {
              
            }else{
                
            }
        }else {
            Utils.showAlert(title: "", msg: "please enter the valid email", selfObj: self) {
                
            }
        }
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
