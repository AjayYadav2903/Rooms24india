//
//  HomeModel.swift
//  Rooms24india
//
//  Created by admin on 25/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeModel: NSObject {

}

// MARK: - Welcome
struct SuccessCheck: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
}

// MARK: - Welcome
struct Welcome: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - Welcome
struct FilterDataModelClass: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
    let data: [Bestdeal]
}

// MARK: - DataClass
struct FilterDataModel: Codable {
    let data, bestdeals, populardestination: [Bestdeal]
}


// MARK: - DataClass
struct DataClass: Codable {
    let nearyou : [Bestdeal]
   // let dormitories: [Dormitory]

}

// MARK: - Dormitory
struct Dormitory: Codable {
    let sid, dormitoryName: String
    let price, discount: Int
    let createdAt, updatedAt, deletedAt: String
    let media: [Media]
  //  let hotelDetails: HotelDetails

    enum CodingKeys: String, CodingKey {
        case sid
        case dormitoryName = "dormitory_name"
        case price, discount
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case media
       // case hotelDetails = "hotel_details"
    }
}

// MARK: - HotelDetails
struct HotelDetails: Codable {
    let sid, hotelName, hotelDescription: String
    let rulesPolicies: [String]
    let rulesPoliciesHTML: JSONNull?
    let hotelImage: String
    let rating, bookingPrice, discount, isPopular: Int
    let createdAt, updatedAt: String
    let deletedAt: JSONNull?
    let address: Address

    enum CodingKeys: String, CodingKey {
        case sid
        case hotelName = "hotel_name"
        case hotelDescription = "hotel_description"
        case rulesPolicies = "rules_policies"
        case rulesPoliciesHTML = "rules_policies_html"
        case hotelImage = "hotel_image"
        case rating
        case bookingPrice = "booking_price"
        case discount
        case isPopular = "is_popular"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case address
    }
}

// MARK: - Bestdeal
struct Bestdeal: Codable {
    let hotelID, imgURL, hotelName, hotelAddress: String
    let hotelRatings: Double
    let isOnWhishList: Bool
    let bookingPrice: Int
    let discountPrice: Int
    let media: [Media]


    enum CodingKeys: String, CodingKey {
        case hotelID
        case imgURL = "imgUrl"
        case hotelName, hotelAddress, hotelRatings, isOnWhishList, bookingPrice, discountPrice, media
    }
}

// MARK: - Media
struct Media: Codable {
    let id: Int
    let sid, itemType, url, createdAt: String
    let updatedAt: String



    enum CodingKeys: String, CodingKey {
        case id, sid
        case itemType = "item_type"
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
