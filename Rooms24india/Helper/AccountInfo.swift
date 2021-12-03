//
//  AccountInfo.swift
//  AirVting
//
//  Created by MACBOOK on 6/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON
//enum StatusAccount: Int {
//    case needVerifiedEmail = 1
//    case needConnectStrike = 2
//}
final class AccountInfo: NSObject, Codable {
    
    // Can't init is singleton
    private override init() { }
    
    // MARK: Shared Instance
    
    static let shared = AccountInfo()
    var isAddessSelected = false

    
    // MARK: Local Variable
    private var tokenId : String = ""
    private var id : String = ""
    var username: String = ""
    private var first_name: String = ""
    private var last_name: String = ""
    private var gender : String = ""
    private var email : String = ""
    private var phone_number: String = ""
    private var featured_image : String = ""
    private var socialType : String = ""
    var ortherUserId : String = ""
    var countPostsFollowing: Int = 0
//    var hasPaymentMethod: Bool = false
    var PaymentMethodIdDefault: String = ""
    var status: Int = 1
    
    
    func saveAccountInfo(json: JSON){
        tokenId = json["data"]["tokenId"].string ?? ""
        countPostsFollowing = json["data"]["countPostsFollowing"].int ?? 0
        id = json["data"]["userDetail"]["_id"].string ?? ""
        username = json["data"]["userDetail"]["username"].string ?? ""
        first_name = json["data"]["userDetail"]["firstName"].string ?? ""
        last_name = json["data"]["userDetail"]["lastName"].string ?? ""
        gender = json["data"]["userDetail"]["gender"].string ?? ""
        email = json["data"]["userDetail"]["email"].string ?? ""
        phone_number = json["data"]["userDetail"]["phone_number"].string ?? ""
        featured_image = json["data"]["userDetail"]["featuredImage"].string ?? ""
        socialType = json["data"]["userDetail"]["socialType"].string ?? ""
//        hasPaymentMethod = json["data"]["userDetail"]["hasPaymentMethod"].bool ?? false
        PaymentMethodIdDefault = json["data"]["PaymentMethodIdDefault"].string ?? ""
        status = json["data"]["userDetail"]["status"].int ?? 1
//        if json["data"]["userDetail"]["status"].int ?? 1 == 1 {
//            status = .needVerifiedEmail
//        } else {
//            status = .needConnectStrike
//        }
        UserDefaults.standard.set(status, forKey: "status")
        UserDefaults.standard.set(tokenId, forKey: "tokenId")
        UserDefaults.standard.set(countPostsFollowing, forKey: "countPostsFollowing")
        UserDefaults.standard.set(id, forKey: "_id")
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(first_name, forKey: "firstName")
        UserDefaults.standard.set(last_name, forKey: "lastName")
        UserDefaults.standard.set(gender, forKey: "gender")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(phone_number, forKey: "phone_number")
        UserDefaults.standard.set(featured_image, forKey: "featuredImage")
        UserDefaults.standard.set(socialType, forKey: "socialType")
//        UserDefaults.standard.set(hasPaymentMethod, forKey: "hasPaymentMethod")
        UserDefaults.standard.set(PaymentMethodIdDefault, forKey: "PaymentMethodIdDefault")
        //Use codable for save Object
        //Set data with keys included userID/...
    }
    
    func setUrlCreateStripeAccount(string: String){
        UserDefaults.standard.set(string, forKey: "UrlCreateStripeAccount")
    }
    
    func getFollow() -> Int {
        return UserDefaults.standard.integer(forKey: "countPostsFollowing")
    }
    
    func getPhone()->String{
        return UserDefaults.standard.string(forKey: "phone_number") ?? ""
    }
    
    func clearAccountInfo() {
        UserDefaults.standard.set("", forKey: "tokenId")
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "_id")
        UserDefaults.standard.set(nil, forKey: "username")
        UserDefaults.standard.set(nil, forKey: "phone_number")
        UserDefaults.standard.set(nil, forKey: "hasPaymentMethod")
        UserDefaults.standard.set(nil, forKey: "PaymentMethodIdDefault")
        UserDefaults.standard.set(nil, forKey: "status")
        UserDefaults.standard.set(nil, forKey: "UrlCreateStripeAccount")
//        self.saveUserModel(user: UserModel())
        self.clearUserModel()
    }
    func storeDeviceToken(fcmToken:String){
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
    }
    func getDeviceToken()->String {
        return UserDefaults.standard.string(forKey: "fcmToken") ?? ""
    }
    
    func storeDeviceUDID(udid:String){
        UserDefaults.standard.set(udid, forKey: "UDID")
    }
    func getDeviceUDID()->String {
        return UserDefaults.standard.string(forKey: "UDID") ?? ""
    }
    
    func storeDeviceModel(model:String){
        UserDefaults.standard.set(model, forKey: "ModelName")
    }
    func getDeviceModel()->String {
        return UserDefaults.standard.string(forKey: "ModelName") ?? ""
    }
    
    /*
    public static func savePlaces(){
        var placeArray = [Place]()
        let place1 = Place(lat: 10.0, long: 12.0)
        let place2 = Place(lat: 5.0, long: 6.7)
        let place3 = Place(lat: 4.3, long: 6.7)
        placeArray.append(place1)
        placeArray.append(place2)
        placeArray.append(place3)
        let placesData = try! JSONEncoder().encode(placeArray)
        UserDefaults.standard.set(placesData, forKey: "places")
    }
    
    public static func getPlaces() -> [Place]?{
        let placeData = UserDefaults.standard.data(forKey: "places")
        let placeArray = try! JSONDecoder().decode([Place].self, from: placeData!)
        return placeArray
    }
 */
    // will use this one to store user info(after signin call api api/v1/users/5b39d8253b0b8e8788659d99 to get info and store
    func saveUserModel(user: UserModel){
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "UserModel")
            UserDefaults.standard.set(user.hasPaymentMethod, forKey: "hasPaymentMethod")
        } else {
            print("save model error")
        }
    }
    func loadUserModel() -> UserModel{
        if let data = UserDefaults.standard.value(forKey: "UserModel") as? Data,
            let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            return user
        }
        return UserModel()
    }
    func clearUserModel(){
        UserDefaults.standard.set(nil, forKey: "UserModel")
    }
    func getEmail()->String{
        let user = loadUserModel()
        return user.email
    }
    func getUserName()->String{
        let user = loadUserModel()
        return user.username
    }
    func checkVerifiedEmail()->Bool{
        let user = loadUserModel()
        return user.isVerified
    }

    func getUrlCreateStripeAccount() -> String{
        let user = loadUserModel()
        return user.urlCreateStripeAccount
    }
    
    func getUrlCreatePaypalAccount() -> String{
           let user = loadUserModel()
           return user.urlCreatePaypalAccount
       }
    func setFCMToken(token: String){
        UserDefaults.standard.set(token, forKey: "FCMToken")
    }
    func getFCMToken() -> String {
        return UserDefaults.standard.string(forKey: "FCMToken") ?? ""
    }
    func setPaymentMethodIdDefault(string: String){
        UserDefaults.standard.set(string, forKey: "PaymentMethodIdDefault")
    }
    func getPaymentMethodIdDefault()->String{
        return UserDefaults.standard.string(forKey: "PaymentMethodIdDefault") ?? ""
    }
    func setHasPaymentMethod(isExist: Bool){
        UserDefaults.standard.set(isExist, forKey: "hasPaymentMethod")
    }
    func getHasPaymentMethod() -> Bool{
        return UserDefaults.standard.bool(forKey: "hasPaymentMethod")
    }
    func getMyId()->String{
        let user = loadUserModel()
        return user._id
    }
    func getToken() -> String {
        return UserDefaults.standard.string(forKey: "tokenId") ?? ""
        
    }
    
    func setKeyRed5ProToLocal(string: String){
        UserDefaults.standard.set(string, forKey: "KeyRed5Pro")
    }
    
    func getKeyRed5ProFromLocal()->String{
        return UserDefaults.standard.string(forKey: "KeyRed5Pro") ?? ""
    }
    
    
    
}
