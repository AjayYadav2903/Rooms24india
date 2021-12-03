//
//  EnterMobileNumberVC.swift
//  Rooms24india
//
//  Created by admin on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import ImageSlideshow
import KRProgressHUD

class EnterMobileNumberVC: UIViewController {

    @IBOutlet weak var imgeSlide: ImageFullScreen!
    @IBOutlet weak var txtMobileNumber : UITextField!

    var arrFeatureImage:[String] = ["https://media.cntraveler.com/photos/5eaa67fbc4e7b60ed557b7f1/master/w_1400,h_939,c_limit/SMP_Rooms_04.2019_Ingals_1400x939_016.jpg","https://assets.simpleviewinc.com/simpleview/image/upload/c_fit,w_750,h_445/crm/santamonica/SMP_Rooms_Ingals_Apr_2019_A2A1594_Exclusive-1-_FAC93C6C-9DE8-455A-8F4D399DDD15FB07_58ea9606-93be-49de-b9e25b367f71833d.jpg","https://imagery.hoteltonight.com/production/attachments/files/6627882/original_normalized.jpg?fit=crop&dpr=1&fm=pjpg&q=50&w=375&h=315","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT8xUrl_xzwJ8rNi3-Qh3rJ7HMC6_0DTbdOHQ&usqp=CAU"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setSlideShowImg()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionNext(_ sender: UIButton) {
        if txtMobileNumber.text?.count == 10 {
        self.serverRequest()
        }else {
            KRProgressHUD.dismiss({
                PopupConfirmCommon.showRequestPopup(strMgs: "please enter the valid mobile number", strTitle: "ERROR")
            })
        }
        
    }
    
    func requestSignUpWithFields() {
        let par = ["phoneNumber":txtMobileNumber.text!] as [String : Any]
        
        WebServices.PostRequest(urlApiString: "https://rooms24india.com/sh/api/v1/signUp", paramters: par as [String : AnyObject]) { (json, message, status) in
            if status == true{
             //   AccountInfo.shared.saveAccountInfo(json: json)
                //                self.changeRootViewHomeVC()
                //TODO: check if can get id?
//                let id: String = json["data"]["userDetail"]["_id"].string ?? ""
//                let user = UserModel(json: json["data"]["userDetail"])
//                AccountInfo.shared.saveUserModel(user: user)
                self.serverRequest()
            } else{
//                KRProgressHUD.dismiss({
//                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
//                })
            }
        }
    }
    
    func serverRequest()  {
        let para: Parameters = ["username":txtMobileNumber.text!,"otp_type":"1"]
        WebServices.postRequestForOtpRegister(urlApiString: "https://rooms24india.com/sh/api/v1/send_signIn_otp", paramters: para) { (json, message, status) in
            if status {
                
                 let welcome = try? JSONDecoder().decode(SuccessCheck.self, from: (json?.rawData())!)
                if welcome!.success {
                    let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "EnterCodeViewController") as! EnterCodeViewController
                    loginStoryBoard.userMobileNumber = self.txtMobileNumber.text!
                    self.present(loginStoryBoard, animated: true) {
                        
                    }
                }else {
                    self.requestSignUpWithFields()
                }
                
            } else{
                 self.requestSignUpWithFields()
                //KRProgressHUD.dismiss({
                   // PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
               // })
            }
        }    }
    
    func setSlideShowImg() {
        //setup slide
        if self.arrFeatureImage.count > 0{
            var datasource:[KingfisherSource] = [KingfisherSource]()
            for img in self.arrFeatureImage {
                datasource.append(KingfisherSource(urlString: img)!)
            }
            
            self.imgeSlide.slideshowInterval = 2.0
            self.imgeSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
            self.imgeSlide.contentScaleMode = UIView.ContentMode.scaleAspectFill
            let pageControl = UIPageControl()
            pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#EC7700")
            pageControl.pageIndicatorTintColor = UIColor(hexString: "#A9A9A9")
            self.imgeSlide.pageIndicator = pageControl
            self.imgeSlide.activityIndicator = DefaultActivityIndicator()
            self.imgeSlide.currentPageChanged = { [unowned self] page in
                //            print("current page:", page)
            }
            self.imgeSlide.setImageInputs(datasource)
        }
    }
}
