//
//  UserModel.swift
//  Rooms24india
//
//  Created by admin on 20/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct UserModel: Codable, Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs._id == rhs._id
    }
    //TODO: Defined from Dummy - need updated
    //var username = ""
//    var avatar = ""
    var photos: [String] = []
    
    //Updated: Defined Get tag users: /api/v1/users
    var des = ""
    var isOnline: Bool = false
    
    /////////update(all info, include: payment, verify email status...
    var socialType: String = ""
    var username: String = ""
    var email: String = ""
    var birth: String = ""
    var date_of_birth: String = ""

    
    var firstName: String = ""
    var lastName: String = ""
    var gender: Int = 0
    var phoneNumber: String = ""
    var featuredImage: String = ""
    var coverImage: String = ""
    var airToken: Int = 0
    var status: Int = 0
    var hasPaymentMethod: Bool = false
    var hasDefaultMethod: String = ""
    var paymentMethodIdDefault: String = ""
    var createdAt: String = ""
    var isVerified: Bool = false
    var _id: String = ""
    var followers: Int = 0
    var following: Int = 0
    var posts: Int = 0
    var urlCreateStripeAccount: String = ""
    var urlCreatePaypalAccount: String = ""

    var isFollow: Bool = false
    var isLive: Bool = false
    var displayName: String = ""
    var liveStreamNotification = true
    var messageNotification = true
    var systemNotification = true
    var locationType = ""
    var locationAddress = ""
    var latitude: Double = 0
    var longitude: Double = 0
    
    init (){
        
    }
    init(json: JSON) {
        //TODO: Defined from Dummy - need updated
//        avatar = json["avatar"].string ?? ""
//        isLive = json["isLive"].bool ?? false
        if let arrPhotos = json["photos"].arrayObject as? [String] {
            for photo in arrPhotos {
                print("__appendPhoto: \(photo)")
                photos.append(photo)
            }
        }
        des = json["des"].string ?? ""
        
        
        //update(all info, include: payment, verify email status.../api/v1/users/{userId}
        //Updated: Defined Get tag users: /api/v1/users
        isOnline = json["isOnline"].bool ?? false
        _id = json["_id"].string ?? json["userId"].string ?? ""
        socialType = json["socialType"].string ?? ""
        username = json["username"].string ?? ""
        email = json["email"].string ?? ""
        birth = json["date_of_birth"].string ?? ""
      //  date_of_birth = json["birth"].string ?? ""

        
        firstName = json["firstName"].string ?? ""
        lastName = json["lastName"].string ?? ""
        gender = json["gender"].int ?? 0
        phoneNumber = json["phoneNumber"].string ?? ""
        featuredImage = json["featuredImage"].string ?? ""
        coverImage = json["coverImage"].string ?? ""
        des = json["description"].string ?? ""
        airToken = json["airToken"].int ?? 0
        status = json["status"].int ?? 0
        hasPaymentMethod = json["hasPaymentMethod"].bool ?? false
        
        hasDefaultMethod = json["hasDefaultMethod"].string ?? ""

        paymentMethodIdDefault = json["paymentMethodIdDefault"].string ?? ""
        createdAt = json["createdAt"].string ?? ""
        isVerified = json["isVerified"].bool ?? false
        followers = json["followers"].int ?? 0
        following = json["following"].int ?? 0
        posts = json["posts"].int ?? 0
        urlCreateStripeAccount = json["urlCreateStripeAccount"].string ?? ""
        urlCreatePaypalAccount = json["urlCreatePaypalAccount"].string ?? ""
        isFollow = json["isFollow"].bool ?? false
        isLive = json["isLive"].bool ?? false
        displayName = json["displayName"].string ?? ""
        liveStreamNotification = json["configs"]["notifications"]["liveStream"].bool ?? true
        messageNotification = json["configs"]["notifications"]["message"].bool ?? true
        systemNotification = json["configs"]["notifications"]["system"].bool ?? true
        locationType = json["location"]["type"].string ?? ""
        locationAddress = json["location"]["address"].string ?? ""
        let coordinates = json["location"]["coordinates"].array ?? []
        if coordinates.count > 0   {
            latitude = Double(coordinates[0].stringValue) ?? 0.0//(coordinates[0].stringValue as! NSString).doubleValue
            longitude = Double(coordinates[1].stringValue) ?? 0.0 //(coordinates[1] as! NSString).doubleValue
        }
    }
}
