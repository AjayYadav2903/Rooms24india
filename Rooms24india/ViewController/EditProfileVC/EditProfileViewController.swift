//
//  EditProfileViewController.swift
//  AirVting
//
//  Created by SeiLK on 7/30/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CountryPickerView
import DatePickerDialog
import IQKeyboardManager
import Alamofire
import SwiftyJSON
import KRProgressHUD
import GooglePlaces
protocol EditProfileViewDelegate: class {
    func didFinishEditProfile()
}

class EditProfileViewController: Rooms24BaseVC, CountryPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate, EditImageViewControllerDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var genderControl: SquareSegmentedControl!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var defaultAvatarLabel: UILabel!
    var countryPickerView: CountryPickerView?
    var doChangeAvatar: Bool = true
    var address = ""
    var latitude: Double = 0
    var longtitude: Double = 0
    var isDisplayingAlert = false
    var enableEditEmail: Bool = false
    weak var delegate: EditProfileViewDelegate?
    var willUpdateFeaturedImage: Bool = false
    var willUpdateCoverImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressField.isUserInteractionEnabled = true
        self.navigationController?.isNavigationBarHidden = true
        setupCountryPickerView()
        descriptionTextView.delegate = self
        birthdayField.delegate = self
        addressField.delegate = self
        userNameField.isUserInteractionEnabled = false
        userNameField.textColor = UIColor.gray
        if enableEditEmail {
            emailField.isUserInteractionEnabled = true
            emailField.backgroundColor = UIColor.white
        } else {
            emailField.isUserInteractionEnabled = false
            emailField.textColor = UIColor.gray
        }
        let font = UIFont(name: "OpenSans-Semibold", size: 14)
        if font != nil {
            genderControl.setTitleTextAttributes([NSAttributedString.Key.font: font!],
                                                 for: .normal)
        }
        self.descriptionLabel.text = "Add a description of yourself".uppercased()
        setupProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func toggleLeftSlide(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        
    }
    
    func setupProfile() {
        KRProgressHUD.show()
        WebServices.getRequest(urlApiString: "\(Constants.Network.getusersprofile)/\(AccountInfo.shared.getMyId())") { (json, message, status) in
            if status == true {
                let user = UserModel(json: json["data"]["userDetail"])
                AccountInfo.shared.saveUserModel(user: user)
                AccountInfo.shared.setPaymentMethodIdDefault(string: json["data"]["PaymentMethodIdDefault"].string ?? "")
                let userDetail = json["data"]["userDetail"]
                self.firstNameField.text = userDetail["firstName"].string ?? ""
                self.lastNameField.text = userDetail["lastName"].string ?? ""
                self.userNameField.text = userDetail["username"].string ?? ""
                let email = userDetail["email"].string ?? ""
                if email == "" {
                    self.emailField.isUserInteractionEnabled = true
                    self.emailField.backgroundColor = UIColor.white
                    self.emailField.textColor = UIColor.black
                } else {
                    self.emailField.text = email
                    self.emailField.textColor = UIColor.gray
                }
                self.avatarImageView.kf.indicatorType = .activity
                self.defaultAvatarLabel.isHidden = true
//                if (userDetail["featuredImage"].string != nil) {
//                    self.avatarImageView.kf.setImage(with: URL(string: userDetail["featuredImage"].string ?? ""))
//                } else {    // get default avatar
//                    self.defaultAvatarLabel.isHidden = false
//                    self.defaultAvatarLabel.setOnlyFirstText(text: userDetail["username"].string!)
//                    self.defaultAvatarLabel.setTextColorGradient()
//                }
                var displayName = userDetail["displayName"].string ?? ""
                if displayName == "" {
                    displayName = userDetail["username"].string ?? ""
                }
                let featuredImage = userDetail["featuredImage"].string ?? ""
                self.willUpdateFeaturedImage = featuredImage == "" ? false : true
                self.avatarImageView.kf.setImage(with: URL(string: featuredImage), placeholder: Utils.genImgWithLetterFrom(displayName: displayName, dimension: self.avatarImageView.frame.width, showBorder: false))
                let coverImage = userDetail["coverImage"].string ?? ""
                self.willUpdateCoverImage = coverImage == "" ? false : true
                if (userDetail["coverImage"].string != nil) {
                    self.coverImageView.kf.setImage(with: URL(string: userDetail["coverImage"].string ?? ""))
                }
                let date = userDetail["date_of_birth"].string
                let dateArr = date?.components(separatedBy: "T")
                let dateS = dateArr?[0]
                self.birthdayField.text = Utils.convertDateToddMMyyyy(dateS ?? "")
                self.genderControl.selectedSegmentIndex = userDetail["gender"].int ?? 0
                
                // address
                self.addressField.text = userDetail["location"]["address"].string ?? ""
                let coordinates = userDetail["location"]["coordinates"].array ?? []
                if coordinates.count > 9 {
                    self.latitude = Double(coordinates[0].stringValue) ?? 0.0//(coordinates[0].stringValue as! NSString).doubleValue
                    self.longtitude = Double(coordinates[1].stringValue) ?? 0.0 //(coordinates[1] as! NSString).doubleValue
                }
                
                // phone number
                let phoneNumber = userDetail["phoneNumber"].string ?? ""
                if phoneNumber.count > 9 {
                    let countryCode = String(phoneNumber.prefix(3))
                    self.countryPickerView?.setCountryByPhoneCode(countryCode)
                    let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
                    let phone = String(phoneNumber.suffix(from: index))
                    let trimmedPhone = phone.trimmingCharacters(in: .whitespaces)
                    self.phoneNumberField.text = trimmedPhone
                }
                
                self.descriptionTextView.text = userDetail["description"].string ?? ""
                self.textViewDidChange(self.descriptionTextView)
            } else {
//                self.showAlert(message: message!)
            }
            KRProgressHUD.dismiss()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == birthdayField {
//            IQKeyboardManager.shared.resignFirstResponder()
            DatePickerDialog().show("birthday", doneButtonTitle: "done", cancelButtonTitle: "cancel", datePickerMode: .date) { (date) -> Void in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.birthdayField.text = formatter.string(from: dt)
                }
            }
            return false
        } else if textField == addressField {
//            let autocompleteController = GMSAutocompleteViewController()
//            autocompleteController.delegate = self
//            GMSPlacesClient.provideAPIKey(Constants.APIKey.googleApiKey)
//            // Specify the place data types to return.
//            let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.formattedAddress.rawValue) |
//                UInt(GMSPlaceField.coordinate.rawValue))!
//            autocompleteController.placeFields = fields
//
//            // Specify a filter.
//            let filter = GMSAutocompleteFilter()
//            filter.type = .address
//            autocompleteController.autocompleteFilter = filter
//
//            // Display the autocomplete view controller.
//            autocompleteController.modalPresentationStyle = .fullScreen
//            present(autocompleteController, animated: true, completion: nil)
            return true
        } else {
            return false
        }
    }
    
    func setupCountryPickerView() {
      //  self.genderControl.setOldLayout(normalColor: UIColor.white, selectedColor: UIColor.darkText)
        countryPickerView = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        countryPickerView?.countryDetailsLabel.font = UIFont(name: "OpenSans-Semibold", size: 14)
        phoneNumberField.leftView = countryPickerView
        
        phoneNumberField.leftViewMode = .always
        
        countryPickerView?.dataSource = self
        countryPickerView?.setCountryByCode("IN")
        countryPickerView?.showPhoneCodeInView = true
        countryPickerView?.showCountryCodeInView = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionLabel.isHidden = descriptionTextView.text.count > 0
    }
    
    //MARK: - CountryPickerViewDataSource
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["IN"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Suggested countries"
    }
    
    //MARK: - ImagePickerView
    
    @IBAction func changeAvatarAction(_ sender: Any) {
        doChangeAvatar = true
        showActionSheet()
    }
    
    @IBAction func changeCoverAction(_ sender: Any) {
        doChangeAvatar = false
        showActionSheet()
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Choose photo source", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
            self.photoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func camera() {
        if self.checkUserPermissionForCameraMicrophone() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                myPickerController.modalPresentationStyle = .fullScreen
                self.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    func photoLibrary() {
        if self.checkUserPermissionForPhotoLibrary() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self;
                myPickerController.sourceType = .photoLibrary
                myPickerController.modalPresentationStyle = .fullScreen
                self.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        self.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage]  as? UIImage {
            if doChangeAvatar {
                willUpdateFeaturedImage = true
//                let vc = UIStoryboard(name: "Posts", bundle: nil).instantiateViewController(withIdentifier: "EditImageViewController") as! EditImageViewController
//                vc.inputImage = image
//                vc.returnMode = .EditProfile
//                vc.delegate = self
//                vc.modalPresentationStyle = .fullScreen
//                present(vc, animated: true, completion: nil)
                self.avatarImageView.image = image
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height
            } else {
                willUpdateCoverImage = true
//                coverImageView.image = image
//                let vc = UIStoryboard(name: "Posts", bundle: nil).instantiateViewController(withIdentifier: "EditImageViewController") as! EditImageViewController
//                vc.inputImage = image
//                vc.returnMode = .EditProfile
//                vc.delegate = self
//                vc.modalPresentationStyle = .fullScreen
//                present(vc, animated: true, completion: nil)
                self.coverImageView.image = image
            }
        }
    }
    
    func didFinishEditImage(image: UIImage) {
        if doChangeAvatar {
            avatarImageView.image = image
            defaultAvatarLabel.isHidden = true
        } else {
            coverImageView.image = image
        }
    }
    
    //MARK: - Validate Fields
    
    func validateFields() -> Bool {
        return validateFirstNameLastName() && validateEmail() && validateBirthday() && validatePhoneField() && validateAddress()
    }
    
    func displayAlertWithMessage(message: String) {
        if !isDisplayingAlert {
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in
                self.isDisplayingAlert = false
            }
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            isDisplayingAlert = true
        }
    }
    
    func validateFirstNameLastName() -> Bool {
        if (firstNameField.text == "") || (lastNameField.text == "") {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter first name and last name.", strTitle: "ERROR")
            return false
        } else {
            return true
        }
    }
    
    func validateUsername() -> Bool {
        if userNameField.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter user name!", strTitle: "ERROR")
            return false
        }
        return true
    }
    
    func validateEmail() -> Bool {
        if emailField.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter email!", strTitle: "ERROR")
            return false
        } else {
            if isValidEmail(testStr: emailField.text!) {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Email is invalid!", strTitle: "ERROR")
                return false
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        
        return result
    }
    
    func validateBirthday() -> Bool {
        if birthdayField.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter birthday!", strTitle: "ERROR")
            return false
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let birthday = formatter.date(from: birthdayField.text!)
            let today = Date()
            let result = today.compare(birthday!)
            if result == .orderedDescending {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Birthday is more than today! Please enter correct birthday!", strTitle: "ERROR")
                return false
            }
        }
    }
    
    func validatePhoneField() -> Bool {
        if phoneNumberField.text! != "" && phoneNumberField.text!.count < 8 {
            PopupConfirmCommon.showRequestPopup(strMgs: "Phone number must be greater then 8 numbers", strTitle: "ERROR")
             return false
        }
        if phoneNumberField.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter phone number", strTitle: "ERROR")
            return false
        } else {
            let phoneNumber = (countryPickerView?.selectedCountry.phoneCode)! + phoneNumberField.text!
            if validatePhoneNumber(value: phoneNumber) {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter correct phone number", strTitle: "ERROR")
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
    
    func validateAddress() -> Bool {
        if addressField.text == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter address.", strTitle: "ERROR")
            return false
        } else {
            return true
        }
    }
    
    //MARK: - Send API
    
    @IBAction func saveEditedProfile(_ sender: Any) {
        if validateFields() {
            KRProgressHUD.show()
            var parameters: Parameters = [
//                "username": userNameField.text!,
                "email": emailField.text!,
                "date_of_birth": birthdayField.text!,
                "firstName": firstNameField.text!,
                "lastName": lastNameField.text!,
                "gender": genderControl.selectedSegmentIndex,
                "phoneNumber": "\(countryPickerView!.selectedCountry.phoneCode) \(phoneNumberField.text!)",
                "description": descriptionTextView.text!
            ]
            if let avatar = self.avatarImageView.image {
                parameters["featuredImage"] = willUpdateFeaturedImage ? avatar : nil
            }
            if let cover = self.coverImageView.image {
                parameters["coverImage"] = willUpdateCoverImage ? cover : nil
            }
            var tagUsersDict: [Parameters] = []
            
            
            let tagDict : Parameters = [
                "coordinates": [latitude , longtitude],
                "address": addressField.text!,
                "type": "Point"
            ]
            tagUsersDict.append(tagDict)
            
//            let locationParams: Parameters = [
//                "type": "Point",
//                "address": addressField.text!,
//                "coordinates": [latitude , longtitude]
//            ]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: tagUsersDict)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            parameters["location"] = jsonString
            print("___uploadParameters: \(parameters)")
            
            WebServices.uploadFile(urlApiString: "\(Constants.Network.users)/\(AccountInfo.shared.getMyId())", method: .post, parameters: parameters, showProgress: true, completion: { [weak self] (json, message, success) in
                guard let owner = self else {return}
                if success == true && json != JSON.null {
                    let user = UserModel(json: json["data"]["userDetail"])
                    AccountInfo.shared.saveUserModel(user: user)
                    AccountInfo.shared.setPaymentMethodIdDefault(string: json["data"]["PaymentMethodIdDefault"].string ?? "")
                    owner.delegate?.didFinishEditProfile()
                    KRProgressHUD.dismiss()
                    owner.dismiss(animated: true, completion: nil)
                } else {
//                    if message != nil {
//                        self.showAlert(message: message!)
//                        print(json)
//                    }
                    print(message)
                }
                KRProgressHUD.dismiss()
            })
        
        }
    }
    
}

extension EditProfileViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.addressField.text = place.formattedAddress
        self.address = place.formattedAddress ?? ""
        self.latitude = place.coordinate.latitude
        self.longtitude = place.coordinate.longitude
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
