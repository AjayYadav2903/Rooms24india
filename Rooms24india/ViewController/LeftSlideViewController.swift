//
//  LeftSlideViewController.swift
//  AirVting
//
//  Created by Admin on 6/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Kingfisher

enum LeftMenuCellType: String {
    case home = "Home"
    case wallet = "Wallet"
    case chatwithus = "Chat"

    case fingerPrint = "Need help ?"
    case contactUS = "Contact Us"
    case billing = "Terms & Condition"
    case setting = "Logout"
    
    var iconName: String {
        get {
            switch self {
            case .home:
                return "home"
            case .wallet:
                return "wallet"
            case .chatwithus:
            return "chaticon"
            case .fingerPrint:
                return "needHelp"
            case .contactUS:
                return "contactUs"
            case .billing:
                return "termsAndCondition"
            case .setting:
                return "logout"
            }
        }
    }
}

class LeftSlideViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var btnAgencyCode: UIButton!

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var displayNameLb: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let itemsCandidate: [LeftMenuCellType] = [.home,.wallet,.contactUS,.billing,.setting]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.isHidden = true
        
        let nib = UINib.init(nibName: Constant.nibName.leftSlideTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: Constant.cellIdentifier.cellLeftSlideReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        tableView.estimatedRowHeight = 85
        
        tableView.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableMenu(_:)), name: Notification.Name(rawValue: "updateTableLeftMenu"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if AccountInfo.shared.loadUserModel().username == "" {
            UserDefaults.standard.set(AccountInfo.shared.loadUserModel().displayName, forKey: "username")
        }
        
        lblMobileNumber.text = AccountInfo.shared.loadUserModel().phoneNumber
        
        
        
    
        
        lbUsername.text = AccountInfo.shared.loadUserModel().displayName == "" ? "Guest" : AccountInfo.shared.loadUserModel().username
        if AccountInfo.shared.loadUserModel().displayName != "" {
            lbUsername.text = AccountInfo.shared.loadUserModel().displayName
        }
        self.avatar.kf.setImage(with: URL(string: AccountInfo.shared.loadUserModel().featuredImage), placeholder: Utils.genImgWithLetterFrom(displayName: AccountInfo.shared.loadUserModel().displayName == "" ? "G" : AccountInfo.shared.loadUserModel().displayName, dimension: self.avatar.frame.width))

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        DispatchQueue.main.async {
            self.avatar.layer.cornerRadius = self.avatar.bounds.size.width / 2.0
            self.avatar.clipsToBounds = true
        }
        
      
        self.tableView.reloadData()
    }
    
    func setupProfile() {
        WebServices.getRequest(urlApiString: "\(Constants.Network.getusersprofile)/\(AccountInfo.shared.getMyId())") { (json, message, status) in
            if status == true {
                let user = UserModel(json: json["data"]["userDetail"])
                AccountInfo.shared.saveUserModel(user: user)
                AccountInfo.shared.setPaymentMethodIdDefault(string: json["data"]["PaymentMethodIdDefault"].string ?? "")
                let userDetail = json["data"]["userDetail"]
              
                let email = userDetail["email"].string ?? ""
                if email == "" {
           
                } else {
                }

                var displayName = userDetail["displayName"].string ?? ""
                if displayName == "" {
                    displayName = userDetail["username"].string ?? ""
                }
                let featuredImage = userDetail["featuredImage"].string ?? ""
                let coverImage = userDetail["coverImage"].string ?? ""
                if (userDetail["coverImage"].string != nil) {
                }
                let date = userDetail["date_of_birth"].string
                let dateArr = date?.components(separatedBy: "T")
                let dateS = dateArr?[0]
                
                // address
                let coordinates = userDetail["location"]["coordinates"].array ?? []
                if coordinates.count > 9 {
                }
                
                // phone number
                let phoneNumber = userDetail["phoneNumber"].string ?? ""
                if phoneNumber.count > 9 {
                    let countryCode = String(phoneNumber.prefix(3))
                    let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
                    let phone = String(phoneNumber.suffix(from: index))
                    let trimmedPhone = phone.trimmingCharacters(in: .whitespaces)
                }
                
            } else {
                //                self.showAlert(message: message!)
            }
        }
    }
    
    @objc func reloadTableMenu(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func btnCopyCode(_ sender: UIButton) {
//        UIPasteboard.general.string = lblagencyCode.text
//        let toast = Toast(text: "Acency code copied in clipboard")
//
//        toast.show()
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        //        PopupConfirmCommon.showRequestPopup(strMgs: "log out question".localized, strTitle: "log out".localized, strActionTitle: "log out".localized, acceptBlock: {
        //            self.logOut()
        //            self.logOutFacebook()
        //        }, rejectBlock: nil)
        self.logOut()
    }
    
    @IBAction func didTouchGoToProfile(_ sender: Any) {
//          let editProfileVC = UIStoryboard(name: "Leftmenu", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
//          let centerNavigation = UINavigationController(rootViewController:editProfileVC)
//                                appDelegate.drawerContainer?.centerViewController = centerNavigation
//                                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
//                                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    func logOut(){
        AccountInfo.shared.clearUserModel()
        UserDefaults.standard.set("", forKey: "tokenId")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navi = UINavigationController(rootViewController: self.getStartVC())
            appDelegate.window?.rootViewController = navi
    }
    
    func getStartVC() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        return mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    }
}

extension LeftSlideViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemsCandidate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier.cellLeftSlideReuseIdentifier) as! LeftSlideTableViewCell
            let cellType = itemsCandidate[indexPath.row]
            cell.lblMenu.text = cellType.rawValue
            cell.imgMenu.image = UIImage(named: cellType.iconName)
            cell.selectionStyle = .none
      
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch itemsCandidate[indexPath.row] {
        case .home:
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
            let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
            let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
            appDelegate.drawerContainer?.centerViewController = centerNavigation
            appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
            appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            appDelegate.drawerContainer?.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionMode.navigationBarOnly
            break
            case .wallet:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)

                break
            
        case .chatwithus:
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Messages", bundle:nil)
            let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
            let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
            appDelegate.drawerContainer?.centerViewController = centerNavigation
            appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
            appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            
            break
            
            
            
            case .fingerPrint:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
 
            case .contactUS:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            case .billing:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "TermsConditionsVC") as! TermsConditionsVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            case .setting:
                UserDefaults.standard.set("", forKey: "tokenId")
               self.logOut()
                
                break
            }
    }
}



