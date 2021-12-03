//
//  AppDelegate.swift
//  Fingerprint
//
//  Created by admin on 02/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import IQKeyboardManager
import GoogleSignIn
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var drawerContainer: MMDrawerController?
    var buildVersion = ""
    var locationManager : CLLocationManager?
    var coordinate : CLLocationCoordinate2D!
    var shareManager : Globals = Globals.sharedInstance
    var isMap = true
    var isLocationCheck = false
    var selectedRoomType = "Classic"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GetCurrentLocation()

        // Google Sign-in
        GIDSignIn.sharedInstance().clientID = "398126898168-spmgs39ql3mfl9ab9q7orfpd03l73mc1.apps.googleusercontent.com"
        IQKeyboardManager.shared().isEnabled = true
        loginFirebase()
        return true
    }
    
    func moveToIntroView()
    {
        let login : LaunchAnimatedVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "LaunchAnimatedVC") as! LaunchAnimatedVC
        let nav: UINavigationController = UINavigationController(rootViewController: login)
        nav.isNavigationBarHidden=true
        nav.setStatusBar(backgroundColor: UIColor.init(red: 248/250, green: 234/250, blue: 26/250, alpha: 1))
        self.window?.rootViewController = nav
    }
    
    func loginFirebase()  {
      
           let login : LaunchAnimatedVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "LaunchAnimatedVC") as! LaunchAnimatedVC
            let nav: UINavigationController = UINavigationController(rootViewController: login)
            nav.isNavigationBarHidden=true
            nav.setStatusBar(backgroundColor: UIColor.init(red: 248/250, green: 234/250, blue: 26/250, alpha: 1))

            self.window?.rootViewController = nav
    }
    
    func welcomeName() {
        
    }
    
    func logOut(){
     
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navi = UINavigationController(rootViewController: self.getStartVC())
            appDelegate.window?.rootViewController = navi
    }
    
    func getStartVC() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        return mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
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
        
        // Cerate MMDrawerController
        //drawerContainer = MMDrawerController(center: mainPage, leftDrawerViewController: leftSideMenuNav)
        drawerContainer = MMDrawerController(center: centerNavigation, leftDrawerViewController: leftSideMenuNav)
        // app.mainNav = mainNavigationController
        drawerContainer?.showsShadow = true
        
        drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
        drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningNavigationBar
        drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        drawerContainer?.closeDrawerGestureModeMask = .tapCenterView
        drawerContainer?.closeDrawerGestureModeMask = .all
        // Assign MMDrawerController to our window's root ViewController
        
        UIApplication.shared.windows.first?.rootViewController = drawerContainer
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}


extension AppDelegate : CLLocationManagerDelegate {
    
        func GetCurrentLocation() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
    //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //        locationManager.startUpdatingLocation()
    //        locationManager.allowsBackgroundLocationUpdates = true
    //        locationManager.pausesLocationUpdatesAutomatically = false
        }
    
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
         //   self.shareManager.iSLocation = true
                coordinate = manager.location!.coordinate
                let locValue : CLLocationCoordinate2D = manager.location!.coordinate
                print("locations = \(locValue.latitude) \(locValue.longitude)")
                
                let location = manager.location?.coordinate
            
            if isMap{
                getAddressFromLatLon(pdblLatitude: "\(locValue.latitude)", withLongitude: "\(locValue.longitude)")
                isMap = false
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            isLocationCheck = true
            if status == .authorizedWhenInUse {
                
    //            locationManager.requestAlwaysAuthorization()
    //            let alert = UIAlertController(title: "You must provide always in use Location", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertControllerStyle.alert)
    //
    //            alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
    //
    //                UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString) as! URL)
    //
    //            }))
    //
    //            self.shareManager.iSLocation = false
    //            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
            if status == .authorizedAlways
            {
                locationManager?.startUpdatingLocation()
                locationManager?.startMonitoringSignificantLocationChanges()
            }
            if status == .denied
            {
    //            locationManager.startUpdatingLocation()
    //            locationManager.startMonitoringSignificantLocationChanges()
    //            let alert = UIAlertController(title: "Location is Disabled", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertController.Style.alert)
    //            alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
    //               // UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString) as! URL)
    //
    //            }))
    //            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    //            self.shareManager.iSLocation = false
                
    //                locationManager?.startUpdatingLocation()
    //                locationManager?.startMonitoringSignificantLocationChanges()
    //                let alert = UIAlertController(title: "Location is Disabled", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertController.Style.alert)
    //                alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
    //                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString) as! URL)
    //
    //                }))
    //                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    //                self.shareManager.iSLocation = false
                    let alert = UIAlertController(title: "Location is Disabled", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertController.Style.alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
                                  alert.dismiss(animated: true, completion: nil)
                              }))
                             
                              self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                              self.shareManager.iSLocation = false
                
            }
            if status == .notDetermined
            {
    //            locationManager.startUpdatingLocation()
    //            locationManager.startMonitoringSignificantLocationChanges()
    //            let alert = UIAlertController(title: "Location is Disabled", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertController.Style.alert)
    //            alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
    //                alert.dismiss(animated: true, completion: nil)
    //            }))
    //
    //            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    //            self.shareManager.iSLocation = false
            }
            if status == .restricted
            {
    //            locationManager.startUpdatingLocation()
    //            locationManager.startMonitoringSignificantLocationChanges()
    //            let alert = UIAlertController(title: "Location is Disabled", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertControllerStyle.alert)
    //            alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
    //                UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString) as! URL)
    //            }))
    //            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    //            self.shareManager.iSLocation = false
                
            }
        }
        
        func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon
            
            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
            
            
            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    if placemarks != nil{
                        let pm = placemarks! as [CLPlacemark]
                        
                        if pm.count > 0 {
                            let pm = placemarks![0]
                            print(pm.country)
                            print(pm.locality)
                            print(pm.subLocality)
                            print(pm.thoroughfare)
                            print(pm.postalCode)
                            print(pm.subThoroughfare)
                            print(pm.administrativeArea)
                           
                            
                            // self.shareManager.stateglobal =
                            var addressString : String = ""
                            if pm.subLocality != nil {
                                addressString = addressString + pm.subLocality! + ", "
                            }
                            if pm.thoroughfare != nil {
                                addressString = addressString + pm.thoroughfare! + ", "
                            }
                            if pm.locality != nil {
                                addressString = addressString + pm.locality! + ", "
                                self.shareManager.cityglobal = pm.locality!
                            }
                            if pm.country != nil {
                                addressString = addressString + pm.country! + ", "
                            }
                            if pm.postalCode != nil {
                                addressString = addressString + pm.postalCode! + " "
                                self.shareManager.zipcodeglobal = pm.postalCode!
                            }
                            if pm.administrativeArea != nil{
                                self.shareManager.stateglobal = pm.administrativeArea!
                            }
                            if pm.subLocality != nil{
                                self.shareManager.subLocality = pm.subLocality!
                            }
                            print(addressString)
                        }
                    }
                    
            })
            
        }

    
}

