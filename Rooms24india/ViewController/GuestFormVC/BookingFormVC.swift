//
//  BookingFormVC.swift
//  Rooms24india
//
//  Created by admin on 22/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MDatePickerView
import Alamofire
import KRProgressHUD

class BookingFormVC: Rooms24BaseVC,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var btnBook : ButtonCustom!

    @IBOutlet weak var topNav : TopViewNav!
    @IBOutlet weak var pickerPersonCount : UIPickerView!

    @IBOutlet weak var btnCheckIn : UIButton!
    @IBOutlet weak var btnCheckOut : UIButton!
    
    @IBOutlet weak var btnAdult : UIButton!
    @IBOutlet weak var btnChild : UIButton!
    
    @IBOutlet weak var txtName : UITextField!
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPhone : UITextField!
    var hotelId = String()
    
    
    var isCheckIn = false
    var personCount = ["1","2","3","4","5" ,"6", "7", "8","9", "10"]
    var btnAdultCount = false
    
   
    lazy var MDate : MDatePickerView = {
        let mdate = MDatePickerView()
        mdate.delegate = self
        mdate.Color = UIColor(red: 0/255, green: 178/255, blue: 113/255, alpha: 1)
        // mdate.cornerRadius = 14
        mdate.translatesAutoresizingMaskIntoConstraints = false
        mdate.from = 1920
        mdate.to = 2050
        return mdate
    }()
    
    let Today : UIButton = {
        let but = UIButton(type:.system)
        but.setTitle("ToDay", for: .normal)
        but.addTarget(self, action: #selector(today), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    let Label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func today() {
        MDate.selectDate = Date()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           MDate.removeFromSuperview()
           Today.removeFromSuperview()
           Label.removeFromSuperview()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")

        btnAdult.setTitle("Adults", for: .normal)
        btnChild.setTitle("Childs", for: .normal)
        btnCheckOut.setTitle("Select Date", for: .normal)
        btnCheckIn.setTitle("Select Date", for: .normal)
        pickerPersonCount.tintColor = UIColor.lightGray
        pickerPersonCount.isHidden = true
        
    }
    
    func serverRequest()  {
        if validateFields() {
            var dateString =  btnCheckIn.titleLabel?.text as! String
            let inputDateFormatter = DateFormatter()
            inputDateFormatter.dateFormat = "dd/MM/yyyy"
            let date = inputDateFormatter.date(from: dateString)

            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd"
            let date1 =  outputDateFormatter.string(from: date!)
            
            var dateString2 =  btnCheckIn.titleLabel?.text as! String
            let inputDateFormatter2 = DateFormatter()
            inputDateFormatter2.dateFormat = "dd/MM/yyyy"
            let date2 = inputDateFormatter2.date(from: dateString2)

            let outputDateFormatter2 = DateFormatter()
            outputDateFormatter2.dateFormat = "yyyy-MM-dd"
            let datel =  outputDateFormatter2.string(from: date2!)
            
            
            let para: Parameters = ["hotelId":"292b8a2c-e5ec-11ea-94b9-e8d0fcec03e2","name":txtName?.text ?? "","phoneNumber":txtPhone?.text ?? "","emailAddress":txtEmail?.text ?? "","checkIn":date1 ,"checkOut":datel ,"adults":btnAdult.titleLabel?.text ?? "","child":btnChild.titleLabel?.text ?? ""]
            WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/hotel_booking", paramters: para) { (json, message, status) in
                if status {
                    KRProgressHUD.dismiss({
                  let str = "Your Booking Has Been Confirmed On \(self.btnCheckIn.titleLabel?.text ?? "") to \(self.btnCheckOut.titleLabel?.text ?? "") at MBD Hotel Noida."
                PopUpConfirmCommon2.showRequestPopup(strMgs: str, strTitle: "Congratulations!", strActionTitle: "Ok", isShowCloseButton: true, isRemoveAllSubview: false, acceptBlock: {
                   
                  let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                    self.navigationController?.pushViewController(loginStoryBoard, animated: true)

                })
                    
                    
                    })


                
                } else{
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                    })
                }
            }
        }else {
            
        }

    }
    
    func validateFields() -> Bool {
        return validateUsername() && validatePhoneField() && validateEmail() && validatePassword() && validateAdultChild()
    }
    
    func validateUsername() -> Bool {
        if txtName.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter user name!", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        }
        return true
    }
    func validatePhoneField() -> Bool {
        if txtPhone.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter phone number", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        } else {
            if txtPhone.text?.count ?? 6 > 9 && txtPhone.text?.count ?? 6 < 11 {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter correct phone number", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                return false
            }
        }
    }
    
    
    
    func validatePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }

    
    func validateEmail() -> Bool {
        if txtEmail.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter email!", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        } else {
            if Utils.isValidEmail(Emailid: txtEmail.text!) {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Email is invalid!", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                return false
            }
        }
    }
    
    func validateAdultChild() -> Bool {
       if btnAdult.titleLabel?.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please select adult members", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        }
        else if btnAdult.titleLabel?.text == "Adults"{
            PopupConfirmCommon.showRequestPopup(strMgs: "Please select adult members", strTitle: "Booking")
            return false
        }
       if btnChild.titleLabel?.text == "" {
           PopupConfirmCommon.showRequestPopup(strMgs: "Please select child members", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
           return false
       }
       else if btnChild.titleLabel?.text == "Childs"{
           PopupConfirmCommon.showRequestPopup(strMgs: "Please select child members", strTitle: "Booking")
           return false
           
       }
        return true
    }

         
         func validatePassword() -> Bool {
            let date1 : String = btnCheckIn.titleLabel!.text!
            let date2 : String = btnCheckOut.titleLabel!.text!
            let isDescending = date1.compare(date2) == ComparisonResult.orderedDescending
            if btnCheckIn.titleLabel?.text == "" {
                 PopupConfirmCommon.showRequestPopup(strMgs: "Please select Check In Time", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                 return false
             }
             else if btnCheckIn.titleLabel?.text == "Select Date"{
                 PopupConfirmCommon.showRequestPopup(strMgs: "Please select Check In Time", strTitle: "Booking")
                 return false
             }
            if btnCheckOut.titleLabel?.text == "" {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please select Check Out Time", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                return false
            }
            else if btnCheckOut.titleLabel?.text == "Select Date"{
                PopupConfirmCommon.showRequestPopup(strMgs: "Please select Check Out Time", strTitle: "Booking")
                return false
                
            }else if isDescending {
                PopupConfirmCommon.showRequestPopup(strMgs: "Check In time can not be greater than Check Out time", strTitle: "Booking")

                return false
            }
             return true
         }
    
    
   @IBAction func btnBackArrow(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnBookNow(_ sender: UIButton) {
        serverRequest()
    }
    
    
    @IBAction func btnActionCheckIn(_ sender: UIButton) {
        isCheckIn = true
      addCalenderView()
    }
    
    func addCalenderView()  {
        view.addSubview(MDate)
              NSLayoutConstraint.activate([
                  MDate.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
                  MDate.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                  MDate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                  MDate.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
              ])
              
              view.addSubview(Today)
              Today.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
              Today.topAnchor.constraint(equalTo: MDate.bottomAnchor, constant: 20).isActive = true
              
              view.addSubview(Label)
              Label.topAnchor.constraint(equalTo: Today.bottomAnchor, constant: 30).isActive = true
              Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    @IBAction func btnActionCheckOut(_ sender: UIButton) {
        isCheckIn = false
       addCalenderView()
    }
    
    @IBAction func btnActionAdults(_ sender: UIButton) {
       pickerPersonCount.isHidden = false
        btnAdultCount = true
    }
    
    @IBAction func btnActionChild(_ sender: UIButton) {
        pickerPersonCount.isHidden = false
        btnAdultCount = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return personCount.count
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if btnAdultCount {
            btnAdult.setTitle(personCount[row], for: .normal)

        }else {
            btnChild.setTitle(personCount[row], for: .normal)

        }
           pickerView.isHidden = true
           
       }
       
       func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
           let attributedString = NSAttributedString(string: personCount[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
           return attributedString
       }
}


extension BookingFormVC : MDatePickerViewDelegate {
    func mdatePickerView(selectDate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: selectDate)
        if isCheckIn {
         btnCheckIn.setTitle(date, for: .normal)
        }else {
         btnCheckOut.setTitle(date, for: .normal)
        }
        
       // candidateForm.dateOfBirth = btnCheckIn.titleLabel?.text ?? ""
    }
}
extension Date {
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}
