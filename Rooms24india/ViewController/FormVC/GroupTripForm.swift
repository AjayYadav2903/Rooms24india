//
//  GroupTripForm.swift
//  Rooms24india
//
//  Created by admin on 22/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import DatePickerDialog

class GroupTripForm: UIViewController {
    
    
    
    @IBOutlet weak var txtFldFirstName : UITextField!
    @IBOutlet weak var txtFldLastName : UITextField!
    @IBOutlet weak var txtFldEmail : UITextField!
    @IBOutlet weak var txtFldPassword : UITextField!
    @IBOutlet weak var txtFldphone : UITextField!

    @IBOutlet weak var btnVisully1 : UIButton!
    @IBOutlet weak var btnVisully2 : UIButton!
    @IBOutlet weak var btnIAgree : UIButton!
    @IBOutlet weak var btnAgreeBound : UIButton!
    
    @IBOutlet weak var btnSelectDate : UIButton!


    var isBtnVisully1 = false
    var isBtnVisully2 = false
    var isBtnIAgree = false
    var isBtnAgreeBound = false
    
    var isAllCheckDone = false
    

    var refresher:UIRefreshControl!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        btnVisully1.setImage(UIImage(named: "untickcoupon"), for: .normal)
        btnVisully2.setImage(UIImage(named: "untickcoupon"), for: .normal)
      //  btnIAgree.setImage(UIImage(named: "untickcoupon"), for: .normal)
        btnAgreeBound.setImage(UIImage(named: "untickcoupon"), for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionVisully1(_ sender: Any) {
        if isBtnVisully1 {
            btnVisully1.setImage(UIImage(named: "untickcoupon"), for: .normal)
            isBtnVisully1 = false
        }else {
            btnVisully1.setImage(UIImage(named: "tickcoupon"), for: .normal)
            isBtnVisully1 = true
        }
    }
    @IBAction func btnActionVisully2(_ sender: Any) {
        if isBtnVisully2 {
            btnVisully2.setImage(UIImage(named: "untickcoupon"), for: .normal)
            isBtnVisully2 = false

        }else {
            btnVisully2.setImage(UIImage(named: "tickcoupon"), for: .normal)
            isBtnVisully2 = true
        }
    }
    
    @IBAction func btnActionIAgree(_ sender: Any) {
        if isBtnIAgree {
            btnIAgree.setImage(UIImage(named: "untickcoupon"), for: .normal)
            isBtnIAgree = false

        }else {
            btnIAgree.setImage(UIImage(named: "tickcoupon"), for: .normal)
            isBtnIAgree = true
        }
    }
    @IBAction func btnActionAgreeBound(_ sender: Any) {
        if isBtnAgreeBound {
            btnAgreeBound.setImage(UIImage(named: "untickcoupon"), for: .normal)
            isBtnAgreeBound = false
        }else {
            btnAgreeBound.setImage(UIImage(named: "tickcoupon"), for: .normal)
            isBtnAgreeBound = true
        }
    }
    
    @IBAction func btnActionSignup(_ sender: UIButton) {
        
        if txtFldFirstName.text! == "" || txtFldLastName.text! == ""  {
            Utils.showAlert(title: "", msg: "Please enter your name", selfObj: self) {
                
            }
            return
        }
        
        if Utils.isValidEmail(Emailid: txtFldEmail.text!) {
            
//            if !validatePassword() {
//
//            }else{
//                getDataApi()
//            }
        }else {
            Utils.showAlert(title: "", msg: "please enter the valid email", selfObj: self) {
                
            }
        }
        
        if btnVisully1.currentImage == UIImage(named: "untickcoupon") {
            Utils.showAlert(title: "", msg: "All Fields are required", selfObj: self) {
                
            }
            return
            
        }
        
        if btnVisully2.currentImage == UIImage(named: "untickcoupon") {
            Utils.showAlert(title: "", msg: "All Fields are required", selfObj: self) {
                
            }
            return
            
        }
        
        //   if btnIAgree.currentImage == UIImage(named: "untickcoupon") {
        //       Utils.showAlert(title: "", msg: "All Fields are required", selfObj: self) {
        //
        //        }
        //        return
        //
        //    }
        
        if btnAgreeBound.currentImage == UIImage(named: "untickcoupon") {
            Utils.showAlert(title: "", msg: "All Fields are required", selfObj: self) {
                
            }
            return
        }
        
        Utils.showAlert(title: "", msg: "Thanks! we will connect with you shortly", selfObj: self) {
            
        }
        
    }
    
    @IBAction func btnActionSelectTripDate(_ sender: UIButton) {
          DatePickerDialog().show("Check OUT", doneButtonTitle: "done", cancelButtonTitle: "cancel", datePickerMode: .dateAndTime) { (date) -> Void in
              if let dt = date {
                  if dt.isPast {
                      PopupConfirmCommon.showRequestPopup(strMgs: "Ohh!! past date", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)

                      return
                  }
                  let formatter = DateFormatter()
                  formatter.dateFormat = "dd-MM-yyyy"
                self.btnSelectDate.setTitle(formatter.string(from: dt), for: .normal)
                
                  
                  // self.birthdayField.text = formatter.string(from: dt)
                  
              }
          }

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
    
    @objc func startRefresher()
    {
        if isInternetAvailable()
        {
            refresher.beginRefreshing()
            getDataApi()
        }
        else
        {
           // self.view.makeToast(Constants.Errors.ERROR_INTERNTE, duration: 2, position: .bottom)
        }
        
    }
    
     func getDataApi()
     {
//         self.startAnimating()
//        let param = ["first_name": txtFldFirstName, "last_name": txtFldLastName,"email": txtFldEmail, "password": txtFldPassword, "phone": txtFldphone]
//
//        AFWrapper.requestPOSTURL(Constants.URLS.Subcategory, params: param as [String : AnyObject], headers: nil, success: { (ResponseJson) in
//            self.stopAnimating()
//
//          //  if ResponseJson["status"] == true {
//                  let login : DashBoardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
//                self.navigationController?.pushViewController(login, animated: true)
//            UserDefaults.standard.set(true, forKey: "isAlreadyLogin")
//
//        //    }
//
//
//                }) { (Error) in
//                    self.stopAnimating()
//                    self.view.makeToast(Constants.Errors.ERROR_TIMEOUT, duration: 2, position: .bottom)
//                }
//     }
    }
}
