//
//  WebServices.swift
//  AirVting
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class WebServices: NSObject {
    
    static let sharedInstance = WebServices()
    public var backgroundSessionManager: Alamofire.SessionManager
    
    private override init() {
        backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.nexlesoft.AirVting2"))
    }
    
    //Use for sigin/signup
    class func PostRequest(urlApiString : String, paramters : [String:AnyObject], showProgress:Bool = true, completion : @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void){
        if showProgress {
            KRProgressHUD.show()
        }
        print("URL ==>>>>>> ", urlApiString)
        print("params ==>>>>>> ", paramters)

        let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
        print()
        Alamofire.request(urlApiString, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            print("URL ==>>>>>> ", urlApiString)
            print(response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        let status = json["success"].int == 1 ? true : false
                        let message = json["message"].string ?? ""
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            if status == false {
                                print(message)
//                                KRProgressHUD.dismiss({
//                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                })
                            }
                        }
                    }catch {
                        print(error)
                        completion(JSON.null, error.localizedDescription, false)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR")
                            })
                    }
                }

                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null,error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
    }
    class func postRequestNew(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
        if showProgress {
            KRProgressHUD.show()
        }
        let header = ["authorization": "Bearer \(AccountInfo.shared.getToken())",
            "language": "en"]
        Alamofire.request(urlApiString, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: header).responseJSON { response in
            print("URL ==>>>>>> ", urlApiString)
            print(response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
//                        let status = json["statusCode"].int == 201 ? true : false
                        let status = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            print(message)
//                            if status == false {
//                                KRProgressHUD.dismiss({
//                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                })
//                            }
                        }
                    }catch {
                        print(error)
                        completion(nil, error.localizedDescription, false)
//                        KRProgressHUD.dismiss({
//                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
//                        })
                    }
                }
                
                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null,error.localizedDescription,false)
                }
            }
            KRProgressHUD.dismiss()
        }
    }
    
        class func getFollowPeople(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
            if showProgress {
                KRProgressHUD.show()
            }
            let header = ["authorization": "Bearer \(AccountInfo.shared.getToken())",
                "language": "en"]
            Alamofire.request(urlApiString, method: .get, parameters: paramters, encoding: URLEncoding.default, headers: header).responseJSON { response in
                print("URL ==>>>>>> ", urlApiString)
                print(response)
                switch response.result {
                case .success:
                    if let actualData = response.data {
                        do {
                            let json = try JSON(data: actualData)
    //                        let status = json["statusCode"].int == 201 ? true : false
                            let status = json["success"].bool ?? false
                            let message = json["message"].string ?? ""
                            if json["statusCode"].int == 401{
                                //                            showAlert(message: "Session expired, please login again".localized)
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                        AccountInfo.shared.clearAccountInfo()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                        appDelegate.window?.rootViewController = startVC
                                    }, rejectBlock: nil)
                                })
                            } else {
                                completion(json,message,status)
                                print(message)
    //                            if status == false {
    //                                KRProgressHUD.dismiss({
    //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
    //                                })
    //                            }
                            }
                        }catch {
                            print(error)
                            completion(nil, error.localizedDescription, false)
    //                        KRProgressHUD.dismiss({
    //                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
    //                        })
                        }
                    }
                    
                    break
                case .failure(let error):
                    print("____api error", error)
                    if error.code == -1009 {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                            }, rejectBlock: nil)
                        })
                    }
                    else {
                        completion(JSON.null,error.localizedDescription,false)
                    }
                }
                KRProgressHUD.dismiss()
            }
        }
    
        class func getLikeDislikeProducts(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
            if showProgress {
                KRProgressHUD.show()
            }
            let header = ["authorization": "Bearer \(AccountInfo.shared.getToken())",
                "language": "en"]
            Alamofire.request(urlApiString, method: .get, parameters: paramters, encoding: URLEncoding.default, headers: header).responseJSON { response in
                print("URL ==>>>>>> ", urlApiString)
                print(response)
                switch response.result {
                case .success:
                    if let actualData = response.data {
                        do {
                            let json = try JSON(data: actualData)
    //                        let status = json["statusCode"].int == 201 ? true : false
                            let status = json["success"].bool ?? false
                            let message = json["message"].string ?? ""
                            if json["statusCode"].int == 401{
                                //                            showAlert(message: "Session expired, please login again".localized)
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                        AccountInfo.shared.clearAccountInfo()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                        appDelegate.window?.rootViewController = startVC
                                    }, rejectBlock: nil)
                                })
                            } else {
                                completion(json,message,status)
                                print(message)
    //                            if status == false {
    //                                KRProgressHUD.dismiss({
    //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
    //                                })
    //                            }
                            }
                        }catch {
                            print(error)
                            completion(nil, error.localizedDescription, false)
    //                        KRProgressHUD.dismiss({
    //                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
    //                        })
                        }
                    }
                    
                    break
                case .failure(let error):
                    print("____api error", error)
                    if error.code == -1009 {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                            }, rejectBlock: nil)
                        })
                    }
                    else {
                        completion(JSON.null,error.localizedDescription,false)
                    }
                }
                KRProgressHUD.dismiss()
            }
        }
    
        class func getBookMarks(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
            if showProgress {
                KRProgressHUD.show()
            }
            let header = ["authorization": "Bearer \(AccountInfo.shared.getToken())",
                "language": "en"]
            Alamofire.request(urlApiString, method: .get, parameters: paramters, encoding: URLEncoding.default, headers: header).responseJSON { response in
                print("URL ==>>>>>> ", urlApiString)
                print(response)
                switch response.result {
                case .success:
                    if let actualData = response.data {
                        do {
                            let json = try JSON(data: actualData)
    //                        let status = json["statusCode"].int == 201 ? true : false
                            let status = json["success"].bool ?? false
                            let message = json["message"].string ?? ""
                            if json["statusCode"].int == 401{
                                //                            showAlert(message: "Session expired, please login again".localized)
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                        AccountInfo.shared.clearAccountInfo()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                        appDelegate.window?.rootViewController = startVC
                                    }, rejectBlock: nil)
                                })
                            } else {
                                completion(json,message,status)
                                print(message)
    //                            if status == false {
    //                                KRProgressHUD.dismiss({
    //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
    //                                })
    //                            }
                            }
                        }catch {
                            print(error)
                            completion(nil, error.localizedDescription, false)
    //                        KRProgressHUD.dismiss({
    //                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
    //                        })
                        }
                    }
                    
                    break
                case .failure(let error):
                    print("____api error", error)
                    if error.code == -1009 {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                            }, rejectBlock: nil)
                        })
                    }
                    else {
                        completion(JSON.null,error.localizedDescription,false)
                    }
                }
                KRProgressHUD.dismiss()
            }
        }
    class func postRequest(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
        if showProgress {
            KRProgressHUD.show()
        }
        let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
        print("Parameters ==>>>>>> ", paramters)

        Alamofire.request(urlApiString, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            print("URL ==>>>>>> ", urlApiString)
            print(response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
//                        let status = json["statusCode"].int == 201 ? true : false
                        let status = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            if status == false {
                                var strMsg =  ""
                                if json["statusCode"].int == 408 && urlApiString.contains("/checkout"){
                                    strMsg = "There was an error processing your order. Please try again."
                                }
                                else {
                                    strMsg = message
                                }
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: strMsg, strTitle: "ERROR")
                                })
                            }
                        }
                    }catch {
                        print(error)
                        completion(nil, error.localizedDescription, false)
//                        KRProgressHUD.dismiss({
//                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
//                        })
                    }
                }
                
                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 || error.code == -1005{
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null,error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
    }
    
        class func postRequestForOtpRegister(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
            if showProgress {
                KRProgressHUD.show()
            }
            let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
            print("Parameters ==>>>>>> ", paramters)

            Alamofire.request(urlApiString, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                print("URL ==>>>>>> ", urlApiString)
                print(response)
                switch response.result {
                case .success:
                    if let actualData = response.data {
                        do {
                            let json = try JSON(data: actualData)
    //                        let status = json["statusCode"].int == 201 ? true : false
                            let status = json["success"].bool ?? false
                            let message = json["message"].string ?? ""
                            if json["statusCode"].int == 401{
                                //                            showAlert(message: "Session expired, please login again".localized)
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                        AccountInfo.shared.clearAccountInfo()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                        appDelegate.window?.rootViewController = startVC
                                    }, rejectBlock: nil)
                                })
                            } else {
                                completion(json,message,status)
                                if status == false {
                                    var strMsg =  ""
                                    if json["statusCode"].int == 408 && urlApiString.contains("/checkout"){
                                        strMsg = "There was an error processing your order. Please try again."
                                    }
                                    else {
                                        strMsg = message
                                    }
//                                    KRProgressHUD.dismiss({
//                                        PopupConfirmCommon.showRequestPopup(strMgs: strMsg, strTitle: "ERROR")
//                                    })
                                }
                            }
                        }catch {
                            print(error)
                            completion(nil, error.localizedDescription, false)
    //                        KRProgressHUD.dismiss({
    //                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
    //                        })
                        }
                    }
                    
                    break
                case .failure(let error):
                    print("____api error", error)
                    if error.code == -1009 || error.code == -1005{
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                            }, rejectBlock: nil)
                        })
                    }
                    else {
                        completion(JSON.null,error.localizedDescription,false)
                    }
                }
                if showProgress {
                    KRProgressHUD.dismiss()
                }
            }
        }
    
        class func postMESSAGERequest(urlApiString : String, paramters : String, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
            if showProgress {
                KRProgressHUD.show()
            }
            var semaphore = DispatchSemaphore (value: 0)

            let parameters = "{\"title\":\"I\",\"content\":\"{\\\"type\\\":\\\"text\\\",\\\"message\\\":\\\"K \\\",\\\"width\\\":0,\\\"height\\\":0}\",\"receivers\":[{\"userId\":\"1e7cdfa9-9136-11ea-93ad-fa163eeeaebe\"}]}"


            let postData = parameters.data(using: .utf8)

            var request = URLRequest(url: URL(string: "http://vridhisoftech.co.in/sh/airvtingApis/api/v1/conversations")!,timeoutInterval: Double.infinity)
            request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTZjOWQ3ZTU0YjY2NzcxMjcxZDY1ODFiNGJiOTA4YzIyNTQ4MGEwMDM2NjM0OGMxMmRkZjBjMDViMjM2NWFiZTMwMmFiOTkyOGVjNDZkNjEiLCJpYXQiOjE1ODk1Mjc3ODgsIm5iZiI6MTU4OTUyNzc4OCwiZXhwIjoxNjIxMDYzNzg4LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.FZGDd3SGgiKwCV7C8rrXnYjqGbxhoYeewoZ9hJXNddIN7MQ7z1AIx-C7o_A2V_BjcTkbKDrkPKdq8BWdho2ixJu1jM7_wvSR1SEaBgtazmS592_LjK8O183F-z1ZgvChw79o9rMOCcZQmtzPUFwrfUSQlnxim2zw8BDwBeOLf8HQo9v9Uf7BZH3hHT0yNwP-KEQrN09VRU_ZiVfKVQi7dvmamldnRmqpYe2zEhcoHImnSFnRRZ8aAFzM_9iZ1A2ZnxllXuJ9yaPIOazZg530Vxfof5hIHazXX_CdlalhdYQJ4ycYVwP34l3m9pay3_lYVzgQyQICmuXYLh9KuYdG90b-bTbRbRv5TrWz2VSbvAykf3ikpA2aN0UWhFbYvTR9GYmO4vSgX2iueb_J_rWjB0Pswgn5FXgvydBKs79KljF8OGxoWVr9XEPuiMI1W27yfJ3j_1UZ_B76VoM-H-L5azN09mVC1fJ9rPztneO41CUp30FtQkUOg8aWbc0Ksm2b781SUD90e8BEXpdp9myDMsauuQ6MTReg595o_fyoDAGCGK4Yx6R2uGIgNk99FiJ8hU3PDlpIo8HNxzbyHUmUtIm92NNPEdCyGzu13Ep4ik4MJ6kYD68M6SQZgOkiB9auPRNGQS866aHzk69Qn9tXm4hWDU8mrrhWDQSb4SPTS0k", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpMethod = "POST"
            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
              semaphore.signal()
            }

            task.resume()
            semaphore.wait()
        }
    
    class func putRequest(urlApiString : String, paramters : Parameters, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
        if showProgress {
            KRProgressHUD.show()
        }
        let header = [
                        "authorization": "Bearer \(AccountInfo.shared.getToken())",
            "language": "en"]
        Alamofire.request(urlApiString, method: .put, parameters: paramters, encoding: URLEncoding.default, headers: header).responseJSON { response in
            print("URL ==>>>>>> ", urlApiString)
            print(response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        let status = json["statusCode"].int == 201 ? true : false
                        let message = json["message"].string ?? ""
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            if status == false {
                                print(message)
//                                KRProgressHUD.dismiss({
//                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                })
                            }
                        }
                    }catch {
                        print(error)
                        completion(nil, error.localizedDescription, false)
//                        KRProgressHUD.dismiss({
//                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
//                        })
                    }
                }
                
                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null,error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
    }
    
    
    
    
    
    class func getRequest(urlApiString : String, showProgress:Bool = false, language: String = "en", parameter: Parameters? = nil, completion : @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void){
//        let header = ["Accept": "application/json",
//                      "authorization": "Bearer \(AccountInfo.shared.getToken())",
//            "language": "\(language)"]
        let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
        if showProgress {
            KRProgressHUD.show()
        }
        print("____api response: \(urlApiString)")
        Alamofire.request(urlApiString, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            print("____api response: \(urlApiString): ", response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        let status = json["statusCode"].int == 201 ? true : false
                        let message = json["message"].string ?? ""
                        //Comment for test
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
    
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            print(message)
//                            if status == false {
//                                KRProgressHUD.dismiss({
//                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                })
//                            }
                        }
                    }catch {
                        print("____api error", error)
                    }
                }
                
                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null, error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
        
        func showAlert(title: String = "", message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let startVC = mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = startVC
            }))
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            let mainController: UIViewController? = keyWindow?.rootViewController
            mainController?.present(alert, animated: true)
        }
    }
    
        class func getRequestWithUrlEncoding(urlApiString : String, showProgress:Bool = false, language: String = "en", parameter: Parameters? = nil, completion : @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void){
    //        let header = ["Accept": "application/json",
    //                      "authorization": "Bearer \(AccountInfo.shared.getToken())",
    //            "language": "\(language)"]
            let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
            if showProgress {
                KRProgressHUD.show()
            }
            print("____api response: \(urlApiString)")
            Alamofire.request(urlApiString, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: header).responseJSON { response in
                print("____api response: \(urlApiString): ", response)
                switch response.result {
                case .success:
                    if let actualData = response.data {
                        do {
                            let json = try JSON(data: actualData)
                            let status = json["statusCode"].int == 201 ? true : false
                            let message = json["message"].string ?? ""
                            //Comment for test
                            if json["statusCode"].int == 401{
                                //                            showAlert(message: "Session expired, please login again".localized)
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                        AccountInfo.shared.clearAccountInfo()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                        appDelegate.window?.rootViewController = startVC
        
                                    }, rejectBlock: nil)
                                })
                            } else {
                                completion(json,message,status)
                                print(message)
    //                            if status == false {
    //                                KRProgressHUD.dismiss({
    //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
    //                                })
    //                            }
                            }
                        }catch {
                            print("____api error", error)
                        }
                    }
                    
                    break
                case .failure(let error):
                    print("____api error", error)
                    if error.code == -1009 {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                            }, rejectBlock: nil)
                        })
                    }
                    else {
                        completion(JSON.null, error.localizedDescription,false)
                    }
                }
                if showProgress {
                    KRProgressHUD.dismiss()
                }
            }
            
            func showAlert(title: String = "", message: String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let startVC = mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = startVC
                }))
                let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                let mainController: UIViewController? = keyWindow?.rootViewController
                mainController?.present(alert, animated: true)
            }
        }
    
    class func deleteRequest(urlApiString : String, paramters : Parameters?, showProgress:Bool = true, completion : @escaping (_ jsonData : JSON?, _ message: String?, _ success : Bool)-> Void){
        if showProgress {
            KRProgressHUD.show()
        }
        let header = [
            "authorization": "Bearer \(AccountInfo.shared.getToken())",
            "language": "en"]
        Alamofire.request(urlApiString, method: .delete, parameters: paramters, encoding: URLEncoding.default, headers: header).responseJSON { response in
            print("URL ==>>>>>> ", urlApiString)
            print(response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        let status = json["statusCode"].int == 201 ? true : false
                        let message = json["message"].string ?? ""
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            print(message)
//                            if status == false {
//                                KRProgressHUD.dismiss({
//                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                })
//                            }
                        }
                    }catch {
                        print(error)
                        completion(nil, error.localizedDescription, false)
//                        KRProgressHUD.dismiss({
//                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR".localized)
//                        })
                    }
                }
                
                break
            case .failure(let error):

                print("____api error", error)
                if error.code == -1009 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null,error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func uploadFile(urlApiString: String, method: HTTPMethod = .post, parameters: Parameters, showProgress:Bool = true, completion: @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void, progress: ((_ progress: Double) -> Void)? = nil){
        let headers = [
            "authorization": "Bearer \(AccountInfo.shared.getToken())",
            "Content-Type": "multipart/form-data; boundary=-----abc"]
        
        if showProgress {
            KRProgressHUD.show()
        }
        let manager = WebServices.sharedInstance.backgroundSessionManager
        manager.session.configuration.timeoutIntervalForResource = 1200
        manager.session.configuration.timeoutIntervalForRequest = 1200
        manager.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let url = value as? URL{
                        // multipartFormData.append(videoUrl, withName: "profileVideo", fileName: "video.mp4", mimeType: "video/mp4")
                        multipartFormData.append(url, withName: key, fileName: "video.mov", mimeType: "video/mov")
//                        multipartFormData.append(url, withName: key)
                    }else if let image = value as? UIImage{
                        let data = image.jpegData(compressionQuality: 0.6)
                        multipartFormData.append(data!, withName: key, fileName: "file.jpg", mimeType: "image/jpg")
                        
                    }
                    else if value is String || value is Int || value is Double {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                    else if let params = value as? Parameters {
                        if let data = try? JSONSerialization.data(withJSONObject: params) {
                            multipartFormData.append(data, withName: "location")
                        }
                    }
                    else if let arr = value as? [Parameters] {
                        for p in arr {
                            if let data = try? JSONSerialization.data(withJSONObject: p) {
                                multipartFormData.append(data, withName: key)
                            }
                        }
                    }
                    
                    print("_____multiPartFormData: \(multipartFormData)")
                }
                
        },
            to: urlApiString,
            method: method,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("__uploadResponse[\(urlApiString)]: \(response)")
                        if let actualData = response.data {
                            do {
                                let json = try JSON(data: actualData)
                                let status = json["statusCode"].int == 201 ? true : false
                                let message = json["message"].string ?? ""
                                if json["statusCode"].int == 401{
                                    //                            showAlert(message: "Session expired, please login again".localized)
                                    KRProgressHUD.dismiss({
                                        PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                            AccountInfo.shared.clearAccountInfo()
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                            appDelegate.window?.rootViewController = startVC
                                        }, rejectBlock: nil)
                                    })
                                } else {
                                    completion(json,message,status)
                                    print(message)
//                                    if status == false {
//                                        KRProgressHUD.dismiss({
//                                            PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                        })
//                                    }
                                }
                            }catch {
                                completion(JSON.null, error.localizedDescription, false)
                            }
                        }
                        if showProgress {
                            KRProgressHUD.dismiss()
                        }
                    }
                    upload.uploadProgress(closure: { (progressValue) in
//                        print("____progress: \(progressValue.fractionCompleted)")
                        if progress != nil {
                            progress!(progressValue.fractionCompleted)
                        }
                    })
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                    if showProgress {
                        KRProgressHUD.dismiss()
                    }
                }
        })
    }
    
    class func uploadMultiplePartWithoutImage(urlApiString: String, method: HTTPMethod = .post, parameters: Parameters, showProgress:Bool = true, completion: @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void, progress: ((_ progress: Double) -> Void)? = nil){
        let headers = [
            "authorization": "Bearer \(AccountInfo.shared.getToken())",
            "language": "en",
            "Content-Type": "multipart/form-data; boundary=-----abc"]
        
        if showProgress {
            KRProgressHUD.show()
        }
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForResource = 1200
        manager.session.configuration.timeoutIntervalForRequest = 1200
        manager.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let url = value as? URL{
                        // multipartFormData.append(videoUrl, withName: "profileVideo", fileName: "video.mp4", mimeType: "video/mp4")
                        multipartFormData.append(url, withName: key, fileName: "video.mov", mimeType: "video/mov")
                        //                        multipartFormData.append(url, withName: key)
                    }else if let image = value as? UIImage{
                        let data = image.jpegData(compressionQuality: 0.6)
                        multipartFormData.append(data!, withName: key, fileName: "file.jpg", mimeType: "image/jpg")
                        
                    }
                    else if value is String || value is Int || value is Double {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                    else if let params = value as? Parameters {
                        if let data = try? JSONSerialization.data(withJSONObject: params) {
                            multipartFormData.append(data, withName: "product")
                        }
                    }
                    else if let arr = value as? [Parameters] {
                        for p in arr {
                            if let data = try? JSONSerialization.data(withJSONObject: p) {
                                multipartFormData.append(data, withName: key)
                            }
                        }
                    }
                    
                    print("_____multiPartFormData: \(multipartFormData)")
                }
                
        },
            to: urlApiString,
            method: method,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("__uploadResponse[\(urlApiString)]: \(response)")
                        if let actualData = response.data {
                            do {
                                let json = try JSON(data: actualData)
                                let status = json["statusCode"].int == 201 ? true : false
                                let message = json["message"].string ?? ""
                                if json["statusCode"].int == 401{
                                    //                            showAlert(message: "Session expired, please login again".localized)
                                    KRProgressHUD.dismiss({
                                        PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                            AccountInfo.shared.clearAccountInfo()
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                            appDelegate.window?.rootViewController = startVC
                                        }, rejectBlock: nil)
                                    })
                                } else {
                                    completion(json,message,status)
                                    print(message)
//                                    if status == false {
//                                        KRProgressHUD.dismiss({
//                                            PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
//                                        })
//                                    }
                                }
                            }catch {
                                completion(JSON.null, error.localizedDescription, false)
                            }
                        }
                        if showProgress {
                            KRProgressHUD.dismiss()
                        }
                    }
                    upload.uploadProgress(closure: { (progressValue) in
                        //                        print("____progress: \(progressValue.fractionCompleted)")
                        if progress != nil {
                            progress!(progressValue.fractionCompleted)
                        }
                    })
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                    if showProgress {
                        KRProgressHUD.dismiss()
                    }
                }
        })
    }
    
        class func postWithTagRequest(urlApiString : String, showProgress:Bool = false, language: String = "en", parameter: Parameters? = nil, completion : @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void){
    //        let header = ["Accept": "application/json",
    //                      "authorization": "Bearer \(AccountInfo.shared.getToken())",
    //            "language": "\(language)"]
            let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
            if showProgress {
                KRProgressHUD.show()
            }
    //        print("____api response: \(urlApiString)")
            Alamofire.request(urlApiString, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                print("____api response: \(urlApiString): ", response)
                switch response.result {
                case .success:
                    if let actualData = response.data {
                        do {
                            let json = try JSON(data: actualData)
                            let status = json["statusCode"].int == 201 ? true : false
                            let message = json["message"].string ?? ""
                            //Comment for test
                            if json["statusCode"].int == 401{
                                //                            showAlert(message: "Session expired, please login again".localized)
                                KRProgressHUD.dismiss({
                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                        AccountInfo.shared.clearAccountInfo()
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                        appDelegate.window?.rootViewController = startVC
        
                                    }, rejectBlock: nil)
                                })
                            } else {
                                completion(json,message,status)
                                print(message)
    //                            if status == false {
    //                                KRProgressHUD.dismiss({
    //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "ERROR".localized)
    //                                })
    //                            }
                            }
                        }catch {
                            print("____api error", error)
                        }
                    }
                    
                    break
                case .failure(let error):
                    print("____api error", error)
                    if error.code == -1009 {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "ERROR", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                            }, rejectBlock: nil)
                        })
                    }
                    else {
                        completion(JSON.null, error.localizedDescription,false)
                    }
                }
                if showProgress {
                    KRProgressHUD.dismiss()
                }
            }
            
            func showAlert(title: String = "", message: String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let startVC = mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = startVC
                }))
                let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                let mainController: UIViewController? = keyWindow?.rootViewController
                mainController?.present(alert, animated: true)
            }
        }
    
    class func cancelAllRequests(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}

class JSONHelper {
    class func jsonStringWithObject(obj: AnyObject) -> String? {
        var error: NSError?
        do {
            let jsonData  = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return NSString(data: jsonData, encoding: 1) as String?

            
        } catch  {
            
        }
        if error != nil {
            print("Error creating JSON data: \(error!.description)");
            return nil
        }
        return ""
    }
}
