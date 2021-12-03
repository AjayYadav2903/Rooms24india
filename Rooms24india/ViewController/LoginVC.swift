//
//  LoginVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import KRProgressHUD
import GoogleSignIn
import SwiftyJSON
import Alamofire
import FacebookLogin
import FBSDKLoginKit
import FacebookCore
import ImageIO
import SwiftyGif

enum SocialType: String {
    case facebook = "facebook"
    case google = "google"
}
class LoginVC: Rooms24BaseVC,GIDSignInDelegate {
    
    @IBOutlet weak var imgLoginBase : UIImageView!

    @IBOutlet weak var lblTermMsg : UILabel!
    @IBOutlet weak var lblWelcomeMsg : UILabel!
    @IBOutlet weak var txtFldName : UITextField!
    @IBOutlet weak var txtFldEmail : UITextField!

    @IBOutlet weak var txtFldPassword : UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin : UIButton!
    @IBOutlet weak var btnSignWithMobile: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFacebook : UIButton!

    @IBOutlet weak var vwloginBase : UIView!
    
    @IBOutlet weak var vwBorderLogin : UIView!
    @IBOutlet weak var vwBorderSignup : UIView!
    @IBOutlet weak var vwOrBase : UIView!

    @IBOutlet weak var heightConstxtFldUser : NSLayoutConstraint!
    @IBOutlet weak var heightConsVwBase : NSLayoutConstraint!

    var isLoginClicked = false
    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let gif = try UIImage(gifName: "logingif.gif", levelOfIntegrity:0.5)
            self.imgLoginBase.setGifImage(gif, loopCount: -1)
        } catch {
            print(error)
        }
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")

        lblTermMsg.text = Constant.StringMsg.contact
        setUpUI()
        // setup Google+
               GIDSignIn.sharedInstance().delegate = self
               GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    func setUpUI()  {
        
        lblTermMsg.isHidden = true
        isLoginClicked = true
        btnLogin.backgroundColor = UIColor.white
        btnLogin.setTitleColor(UIColor.black, for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        txtFldName.setIconOnTextFieldLeft(UIImage(named: "userIcon")!)
        txtFldEmail.setIconOnTextFieldLeft(UIImage(named: "emailIcon")!)
        txtFldPassword.setIconOnTextFieldLeft(UIImage(named: "password")!)
        Utils.changePlaceholderColor(txtFld: txtFldPassword, text: "Password")
        Utils.changePlaceholderColor(txtFld: txtFldName, text: "Username")
        Utils.changePlaceholderColor(txtFld: txtFldEmail, text: "Email Address")

        vwBorderSignup.isHidden = true
        vwBorderLogin.isHidden = false
        heightConstxtFldUser.constant = 0
        heightConsVwBase.constant = -50
        txtFldName.isHidden = true
    }
    
    @IBAction func btnSkipLogin(_ sender: UIButton) {
        self.buildNavigationDrawer()
    }
    
    @IBAction func btnActionSignUp(_ sender: UIButton) {
        lblTermMsg.isHidden = false
        txtFldPassword.text = ""
        txtFldEmail.text = ""
        txtFldName.text = ""
        isLoginClicked = false
        vwBorderLogin.isHidden = true
        vwBorderSignup.isHidden = false
        heightConstxtFldUser.constant = 40
        txtFldName.isHidden = false
        heightConsVwBase.constant = 50
        btnGoogle.isHidden = true
        btnFacebook.isHidden = true
        vwOrBase.isHidden = true
        btnSignWithMobile.isHidden = true
        //  btnSignUp.backgroundColor = UIColor.white
        //  btnSignUp.setTitleColor(UIColor.black, for: .normal)
        
        //  btnLogin.backgroundColor = UIColor.clear
        //  btnLogin.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func btnActionLogin(_ sender: UIButton) {
        lblTermMsg.isHidden = true
        txtFldPassword.text = ""
        txtFldEmail.text = ""
        txtFldName.text = ""
        isLoginClicked = true
        vwBorderSignup.isHidden = true
        vwBorderLogin.isHidden = false
        heightConstxtFldUser.constant = 0
        heightConsVwBase.constant = -50
        txtFldName.isHidden = true
        btnGoogle.isHidden = false
        btnFacebook.isHidden = false
        vwOrBase.isHidden = false
        btnSignWithMobile.isHidden = false
//        let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
//        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
    }
    
    @IBAction func btnActionLoginSignUp(_ sender: UIButton) {
        if isLoginClicked {
            requestToLogin()
        }else {
            if validateFields() {
                requestSignUpWithFields()
            }
        }
    }
    
    @IBAction func btnActionGoogleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    
        
    @IBAction func btnActionFBLogin(_ sender: UIButton) {
        let login = LoginManager()
        login.logOut()
        login.logIn(permissions: ["public_profile", "email"], from: self) {[weak self] (result, error) in
            guard let owner = self else {return}
            if error == nil {
                if AccessToken.current != nil {
                    GraphRequest(graphPath: "me", parameters: ["fields" : "id, name, first_name, last_name, picture.type(large), email, birthday, gender "]).start(completionHandler: {[weak self] (connection, result1, error) -> Void in
                        guard let owner = self else {return}
                        if let data = result1 as? [String: Any], let resultID = data["id"] , error == nil {
                            print(data, resultID)
                            var urlImg = ""
                            if let picture = data["picture"] {
                                let json = JSON(picture)
                                urlImg = json["data"]["url"].string ?? ""
                            }
                            let parameters: Parameters = [
                                "socialId": data["id"] ?? "",
                                "socialType": SocialType.facebook.rawValue,
                                "socialToken": AccessToken.current?.tokenString ?? "",
                                "email": data["email"] ?? "",
                                "birth": data["birthday"] ?? "",
                                "firstName": data["first_name"] ?? "",
                                "lastName": data["last_name"] ?? "",
                                "gender": data["gender"] ?? "",
                                "phoneNumber": data["phone"] ?? "",
                                "featuredImage":urlImg,
                                "username":data["first_name"] ?? ""
                            ]
                            owner.callAPILoginFB(parameters: parameters)
                        }
                      
                    })
                }
            } else if (result?.isCancelled)! {
                print("Cancel")
            }
        }
    }
    
    @IBAction func btnActionSignInWithMobile(_ sender: UIButton) {
               let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "EnterMobileNumberVC") as! EnterMobileNumberVC
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
        
      //  self.buildNavigationDrawer()
    }
    
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            //TODO: Get user info for server
            if user == nil {
                return
            }
            let userId = user.userID
            let idToken = user.authentication.idToken
    //        let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let avatar = "\(user.profile.imageURL(withDimension: 100))"
            let parameters: Parameters = [
                "socialId": userId ?? "",
                "socialType": SocialType.google.rawValue,
                "socialToken": idToken ?? "",
                "email": email ?? "",
                "firstName": familyName ?? "",
                "lastName": givenName ?? "",
                "featuredImage":avatar ?? ""
            ]
            self.callAPILoginGg(parameters: parameters)
            // Then push segue
            if error != nil {
                print(error)
            } else {
    //            self.performSegue(withIdentifier: "signUpFirstSegue", sender: nil)
            }
        }
        func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
            guard error == nil else {
                
                print("Error while trying to redirect : \(error)")
                return
            }
            
            print("Successful Redirection")
        }

    
    func requestToLogin() {
    //        self.changeRootViewHomeVC()
            let username: String = txtFldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password: String = txtFldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !self.validateEmail(str: txtFldEmail.text!, strTitle: "signin") {return}
        if !self.validatePassword(str: txtFldPassword.text!) {return}
            let param = ["username": username, "password": password]
            WebServices.PostRequest(urlApiString: Constants.Network.signIn, paramters: param as [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
                guard let owner = self else {return}
                if status == true{
                    AccountInfo.shared.saveAccountInfo(json: json)
                    //                self.changeRootViewHomeVC()
                    //TODO: check if can get id?
                    let id: String = json["data"]["userDetail"]["_id"].string ?? ""
                    let user = UserModel(json: json["data"]["userDetail"])
                    AccountInfo.shared.saveUserModel(user: user)
                  //  AccountInfo.shared.setPaymentMethodIdDefault(string: json["data"]["PaymentMethodIdDefault"].string ?? "")
                    self?.buildNavigationDrawer()
                    //end ajay
                } else {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                    })
                }
            }
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
        
        func validatePassword(str:String) -> Bool {
            if str == "" {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter password!", strTitle: "signin", acceptBlock: nil, rejectBlock: nil)
                return false
            }
    //        else if str.length < 7{
    //            PopupConfirmCommon.showRequestPopup(strMgs: "Password must be greater than 6 characters".localized, strTitle: "signin".localized)
    //            return false
    //        }
            return true
        }
    
    func validateFields() -> Bool {
            return validateUsername() && validateEmail() && validatePassword()
        }
       
        func validateUsername() -> Bool {
            if txtFldName.text == "" {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter user name!", strTitle: "signup", acceptBlock: nil, rejectBlock: nil)
                return false
            }
            return true
        }
        
        func validateEmail() -> Bool {
            if txtFldEmail.text == "" {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter email!", strTitle: "signup", acceptBlock: nil, rejectBlock: nil)
                return false
            } else {
                if Utils.isValidEmail(Emailid: txtFldEmail.text!) {
                    return true
                } else {
                    PopupConfirmCommon.showRequestPopup(strMgs: "Email is invalid!", strTitle: "signup", acceptBlock: nil, rejectBlock: nil)
                    return false
                }
            }
        }

        
        func validatePassword() -> Bool {
            if txtFldPassword.text == "" {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter password!", strTitle: "signup", acceptBlock: nil, rejectBlock: nil)
                return false
            }
            else if self.txtFldPassword.text?.count ?? 0 < 9{
                PopupConfirmCommon.showRequestPopup(strMgs: "Password must be greater than 8 characters", strTitle: "signup")
                return false
            }else if !Utils.isValidPassword(Password: txtFldPassword.text) {
                PopupConfirmCommon.showRequestPopup(strMgs: "password must contain uppercase lowercase and number", strTitle: "signup")
              return false
            }
            return true
        }
        
        func requestSignUpWithFields() {
            
            let par = ["username": txtFldName.text?.trimmingCharacters(in: .whitespaces),
                "email": txtFldEmail.text?.trimmingCharacters(in: .whitespaces),
                "password": txtFldPassword.text,
                "firstName":txtFldName.text?.trimmingCharacters(in: .whitespaces),
                "lastName":"",
                "gender":"0",
                "phoneNumber":""
                 ] as [String : Any]
 
            WebServices.PostRequest(urlApiString: Constants.Network.signUp, paramters: par as [String : AnyObject]) { (json, message, status) in
                if status == true{
                    AccountInfo.shared.saveAccountInfo(json: json)
                    //                self.changeRootViewHomeVC()
                    //TODO: check if can get id?
                    let id: String = json["data"]["userDetail"]["_id"].string ?? ""
                    let user = UserModel(json: json["data"]["userDetail"])
                    AccountInfo.shared.saveUserModel(user: user)
                self.buildNavigationDrawer()
                } else{
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                    })
                }
            }
        }
    
    
    func buildNavigationDrawer()
    {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
        var mainNavigationController = UIViewController()
        
        mainNavigationController =  mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
       
        let leftSideMenu : LeftSlideViewController = UIStoryboard(name: "Leftmenu", bundle: nil).instantiateViewController(withIdentifier: "LeftSlideViewController") as! LeftSlideViewController
        
        
        // Wrap into Navigation controllers
        let leftSideMenuNav = UINavigationController(rootViewController:leftSideMenu)
        let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
        leftSideMenuNav.setStatusBar(backgroundColor: UIColor.init(red: 248/250, green: 234/250, blue: 26/250, alpha: 1))
        centerNavigation.setStatusBar(backgroundColor: UIColor.init(red: 248/250, green: 234/250, blue: 26/250, alpha: 1))
        
        // Cerate MMDrawerController
        //drawerContainer = MMDrawerController(center: mainPage, leftDrawerViewController: leftSideMenuNav)
        appDelegate.drawerContainer = MMDrawerController(center: centerNavigation, leftDrawerViewController: leftSideMenuNav)
        // app.mainNav = mainNavigationController
        appDelegate.drawerContainer?.showsShadow = true
        
        appDelegate.drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
        appDelegate.drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        appDelegate.drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningNavigationBar
        appDelegate.drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        appDelegate.drawerContainer?.closeDrawerGestureModeMask = .tapCenterView
        appDelegate.drawerContainer?.closeDrawerGestureModeMask = .all
        // Assign MMDrawerController to our window's root ViewController
        
        UIApplication.shared.windows.first?.rootViewController = appDelegate.drawerContainer
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension LoginVC{
    
    func callAPILoginFB(parameters: Parameters) {
        WebServices.postRequest(urlApiString: Constants.Network.socialSignIn, paramters: parameters) { (json, message, status) in
            if status == true && json != nil{
                AccountInfo.shared.saveAccountInfo(json: json!)
//                self.changeRootViewHomeVC()
                //TODO: check if can get id?
                let id: String = json!["data"]["userDetail"]["_id"].string ?? ""
                let user = UserModel(json: json!["data"]["userDetail"])
                AccountInfo.shared.saveUserModel(user: user)
                // AccountInfo.shared.setPaymentMethodIdDefault(string: json["data"]["PaymentMethodIdDefault"].string ?? "")
                self.buildNavigationDrawer()
              //  self.getUserInfo(idUser: id)
     //           self.updateFCMToken()
            } else{
//                if message != nil {
//                    self.showAlert(message: message!)
//                }
            }
        }
    }

    func callAPILoginGg(parameters: Parameters) {
        WebServices.postRequest(urlApiString: Constants.Network.socialSignIn, paramters: parameters) { (json, message, status) in
            if status == true && json != nil{
                AccountInfo.shared.saveAccountInfo(json: json!)
//                self.changeRootViewHomeVC()
                let id: String = json!["data"]["userDetail"]["_id"].string ?? ""
                let user = UserModel(json: json!["data"]["userDetail"])
                AccountInfo.shared.saveUserModel(user: user)
                // AccountInfo.shared.setPaymentMethodIdDefault(string: json["data"]["PaymentMethodIdDefault"].string ?? "")
               self.buildNavigationDrawer()
               // self.getUserInfo(idUser: id)
       //         self.updateFCMToken()
            } else{
//                if message != nil {
//                    self.showAlert(message: message!)
//                }
            }
        }
    }
}
