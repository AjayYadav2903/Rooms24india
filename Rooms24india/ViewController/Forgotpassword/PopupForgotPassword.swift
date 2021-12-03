//
//  PopupForgotPassword.swift
//  AirVting
//
//  Created by Giêng Thành on 10/5/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import IQKeyboardManager
import Alamofire
class PopupForgotPassword: Rooms24BaseVC, UIGestureRecognizerDelegate {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tapAbleView: UIView!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var centerVerticalVContent: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTouchReject(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        self.lblTitle.text = "forgot password"
        self.lblDes.text = "Please Enter Your Sign-Up Email"
        self.btnOk.setTitle("SUBMIT", for: .normal)
        self.txtEmail.placeholder = "Enter Your Email Here"
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    deinit {
        print("Deinit PopupForgotPassword")
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func didTouchOk(_ sender: Any) {
        self.view.endEditing(true)
        let username: String = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !self.validateEmail(str: username,strTitle: "forgot password") {return}
        self.sendEmail(email: username)
    }
    
    func validateEmail(str:String,strTitle:String) -> Bool {
        if str == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter email!", strTitle: strTitle, acceptBlock: nil, rejectBlock: nil)
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
    
    func sendEmail(email: String){
        let param: Parameters = ["email":email]
        WebServices.postRequest(urlApiString: Constants.Network.forgotPass, paramters: param) { (json, message, status) in
            if status {
                self.dismiss(animated: true, completion: nil)
            } else {
                //                KRProgressHUD.dismiss({
                //                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "forgot password".localized)
                //                })
            }
        }
    }
    
    @IBAction func didTouchReject(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.vContent {
            return false
        }
        return true
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let heightVcontent = self.vContent.frame.size.height
            let heightDevice = UIScreen.main.bounds.size.height
            let bottomContraintVContent = (heightDevice / 2) - (heightVcontent / 2)
            if endFrame == nil {return}
            if bottomContraintVContent < endFrame?.size.height ?? 0 {
                let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
                let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
                let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
                let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
                if (endFrame?.origin.y)! >= heightDevice {
                    self.centerVerticalVContent.constant = 0
                } else {
                    self.centerVerticalVContent.constant = -((endFrame?.size.height ?? 0) - bottomContraintVContent)
                }
                UIView.animate(withDuration: duration,
                               delay: TimeInterval(0),
                               options: animationCurve,
                               animations: { self.view.layoutIfNeeded() },
                               completion: nil)
            }
            
        }
    }
}





