//
//  EnterCodeViewController.swift
//  AirVting
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD

class EnterCodeViewController: UIViewController {

    var arrBackground: [UIImageView] = [UIImageView]()
    var arrCode:[UILabel] = [UILabel]()
    var userMobileNumber = ""
        
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgBackground1: UIImageView!
    @IBOutlet weak var imgBackground2: UIImageView!
    @IBOutlet weak var imgBackground3: UIImageView!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbCode1: UILabel!
    @IBOutlet weak var lbCode2: UILabel!
    @IBOutlet weak var lbCode3: UILabel!
    
    @IBOutlet weak var btnVerify: UIButton!

    
    @IBOutlet weak var lblResendCode: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnVerify.isUserInteractionEnabled = false
        btnVerify.alpha = 0.6
        arrBackground.append(imgBackground)
        arrBackground.append(imgBackground1)
        arrBackground.append(imgBackground2)
        arrBackground.append(imgBackground3)

        arrCode.append(lbCode)
        arrCode.append(lbCode1)
        arrCode.append(lbCode2)
        arrCode.append(lbCode3)
        
        let image = UIImage(named: "ic_logo")
        self.navigationItem.titleView = UIImageView(image: image)

    }
    
    @IBAction func insertCode(_ sender: UIButton) {
        print(sender.titleLabel!.text ?? 0)
        setCode(code: Int(sender.titleLabel!.text!) ?? 0)
    }
    
    func setCode(code: Int){
        for i in 0...3{
            if arrCode[i].text == ""{
                arrCode[i].text = "\(code)"
                arrBackground[i].image = UIImage(named: "background_label_code")
                if i == 3 {
                          btnVerify.isUserInteractionEnabled = true
                          btnVerify.alpha = 1
                      }else {
                          btnVerify.isUserInteractionEnabled = false
                          btnVerify.alpha = 0.6
                      }
                break
            }
        }
        
    }
    
    @IBAction func clearCode(_ sender: UIButton) {

        for i in (0...3).reversed() {
            if arrCode[i].text != ""{
                arrCode[i].text = ""
                arrBackground[i].image = UIImage(named: "border_label_code")
                
                btnVerify.isUserInteractionEnabled = false
                btnVerify.alpha = 0.6
                
                break
            }
           
        }
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        if arrCode.count == 4 {
            serverRequest()
        }
    }
    func serverRequest()  {
        let code = "\(arrCode[0].text!)\(arrCode[1].text!)\(arrCode[2].text!)\(arrCode[3].text!)"
        
        let para: Parameters = ["username":userMobileNumber,"otp":code]
        WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/verify_otp", paramters: para) { (json, message, status) in
            if status {
                
               // let welcome = try? JSONDecoder().decode(Welcome.self, from: (json?.rawData())!)
                self.changeRootViewBasketVC()
                
            } else{
               // KRProgressHUD.dismiss({
               //     PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
              //  })
            }
        }    }
    
    @IBAction func btnResendCode(_ sender: Any) {
          
    }
    
    func changeRootViewBasketVC(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.buildNavigationDrawer()
    }
}
