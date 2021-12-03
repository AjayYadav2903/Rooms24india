//
//  Rooms24BaseVC.swift
//  Rooms24india
//
//  Created by admin on 24/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
//import EFInternetIndicator
import Alamofire
import KRProgressHUD
import SwiftyJSON
import AVFoundation
import Photos

//class Rooms24BaseVC: UIViewController,InternetStatusIndicable {

class Rooms24BaseVC: UIViewController {
    
  //  var internetConnectionIndicator:InternetViewIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.startMonitoringInternet()
    }
    
    //MARK: Check user's permission for photo library, camera and microphone
    
    func checkUserPermissionForCameraMicrophone() -> Bool {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        let microphoneAuthorizationStatus = AVAudioSession.sharedInstance().recordPermission
        if cameraAuthorizationStatus == .denied || microphoneAuthorizationStatus == .denied {
            PopupConfirmCommon.showRequestPopup(strMgs: "If you rejected permission", strTitle: "Attention", strActionTitle: "Open settings", acceptBlock: {
                self.dismiss(animated: true, completion: nil)
                if let url = URL(string:UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }
            }, rejectBlock: {
                self.dismiss(animated: true, completion: nil)
            })
            return false
        } else {
            return true
        }
    }
    
    func checkUserPermissionForPhotoLibrary() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .denied {
            PopupConfirmCommon.showRequestPopup(strMgs: "If you rejected permission", strTitle: "Attention", strActionTitle: "Open settings", acceptBlock: {
                self.dismiss(animated: true, completion: nil)
                if let url = URL(string:UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }
            }, rejectBlock: {
                self.dismiss(animated: true, completion: nil)
            })
            return false
        }else if status == .notDetermined {
            var sta = true
            PHPhotoLibrary.requestAuthorization({
                           (newStatus) in
                           DispatchQueue.main.async {
                               if newStatus ==  PHAuthorizationStatus.authorized {
                                  // self.present(imagePickerController, animated: true, completion: nil)
                               sta = true
                                return
                               }else{
                                sta = false
                                   print("User denied")
                               }
                           }})
            return sta
        } else {
            return true
        }
    }
}
