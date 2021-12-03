//
//  LaunchAnimatedVC.swift
//  Rooms24india
//
//  Created by admin on 20/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ImageIO

class LaunchAnimatedVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var imgLoginLogo : UIImageView!
    @IBOutlet weak var imgLoginGif : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
                   let gif = try UIImage(gifName: "Logo.gif", levelOfIntegrity:0.5)
                   self.imgLoginLogo.setGifImage(gif, loopCount: -1)
               } catch {
                   print(error)
               }
        do {
                   let gif = try UIImage(gifName: "logingif.gif", levelOfIntegrity:0.5)
                   self.imgLoginGif.setGifImage(gif, loopCount: -1)
               } catch {
                   print(error)
               }

        
        self.navigationController?.isNavigationBarHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.loginFirebase()
        }
    }
    
    func loginFirebase()  {
        if AccountInfo.shared.getToken() != "" {
            // already login
            self.buildNavigationDrawer()
        }else {
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)
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
        
        
       // appDelegate.drawerContainer?.closeDrawerGestureModeMask = .all
        appDelegate.drawerContainer?.closeDrawerGestureModeMask = .all
        // Assign MMDrawerController to our window's root ViewController
        
        UIApplication.shared.windows.first?.rootViewController = appDelegate.drawerContainer
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
