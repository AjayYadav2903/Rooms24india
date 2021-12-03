//
//  BookingsModel.swift
//  Rooms24india
//
//  Created by admin on 25/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation

//class BookingsModel: NSObject {
//
//}
//
//// MARK: - Welcome
//struct BookingListData: Codable {
//    let statusCode: Int
//    let success: Bool
//    let message: String
//    let data: DataClassBooking
//}
//
//// MARK: - DataClass
//struct DataClassBooking: Codable {
//    let booking_list : [Datum]
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    let sid: String
//    let userIDFk: Int
//    let name, phoneNumber, emailAddress, checkIn: String
//    let checkOut: String
//    let adults, child: Int
//    let createdAt, updatedAt: String
//    let hotel: Hotel
//
//    enum CodingKeys: String, CodingKey {
//        case sid
//        case userIDFk = "user_id_fk"
//        case name, phoneNumber, emailAddress, checkIn, checkOut, adults, child
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case hotel
//    }
//}
//
//// MARK: - Hotel
struct Hotel: Codable {
    let sid, hotelName, hotelDescription, hotelImage: String
    let rating: Double
    let bookingPrice, isPopular: Int
    let createdAt, updatedAt: String
    let media: [Media]

    enum CodingKeys: String, CodingKey {
        case sid
        case hotelName = "hotel_name"
        case hotelDescription = "hotel_description"
        case hotelImage = "hotel_image"
        case rating
        case bookingPrice = "booking_price"
        case isPopular = "is_popular"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case media

    }
}

// MARK: - Encode/decode helpers

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct BookingListData: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
    let data: DataClassBooking
}

// MARK: - DataClass
struct DataClassBooking: Codable {
    let bookingList: [Datum]

    enum CodingKeys: String, CodingKey {
        case bookingList = "booking_list"
    }
}

// MARK: - BookingList
struct Datum: Codable {
    let sid, userName, userPhone: String
    let bookingType: Int
    let checkIn, checkOut: String
    let adults, child, unitPrice, numberOfRooms: Int
    let subTotal, tax, couponDiscount, grandTotal: Int
    let status: Int
    let refundStatus: Int?
    let refundComment: String?
    let createdAt, updatedAt: String
    let hotelDetails: Hotel

    enum CodingKeys: String, CodingKey {
        case sid
        case userName = "user_name"
        case userPhone = "user_phone"
        case bookingType = "booking_type"
        case checkIn = "check_in"
        case checkOut = "check_out"
        case adults, child
        case unitPrice = "unit_price"
        case numberOfRooms = "number_of_rooms"
        case subTotal = "sub_total"
        case tax
        case couponDiscount = "coupon_discount"
        case grandTotal = "grand_total"
        case status
        case refundStatus = "refund_status"
        case refundComment = "refund_comment"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelDetails = "hotel_details"
    }
}

// MARK: - HotelDetails
//struct HotelDetails: Codable {
//    let sid, type, hotelName, hotelDescription: String
//    let rulesPolicies: [String]
//    let hotelImage: String
//    let rating, bookingPrice, discount, isPopular: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case sid, type
//        case hotelName = "hotel_name"
//        case hotelDescription = "hotel_description"
//        case rulesPolicies = "rules_policies"
//        case hotelImage = "hotel_image"
//        case rating
//        case bookingPrice = "booking_price"
//        case discount
//        case isPopular = "is_popular"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}

// MARK: - UserDetails
//struct UserDetails: Codable {
//    let sid, name, phone, email: String
//    let gender: Int
//    let profileImage: String
//    let islive: Int
//    let status: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case sid, name, phone, email, username
//        case emailVerifiedAt = "email_verified_at"
//        case gender
//        case socialID = "socialId"
//        case socialType, profileImage, birth, socialToken, islive
//        case totalStreamTime = "total_stream_time"
//        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case deletedAt = "deleted_at"
//    }
//}

