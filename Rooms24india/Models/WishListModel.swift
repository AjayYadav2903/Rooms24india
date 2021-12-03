//
//  WishListModel.swift
//  Rooms24india
//
//  Created by admin on 21/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class WishListModel: NSObject {

}

import Foundation

//// MARK: - Welcome
//struct WishListData: Codable {
//    let statusCode: Int
//    let success: Bool
//    let message: String
//    let data: DataClassWishlist
//}
//
//struct DataClassWishlist : Codable {
//    let whish_list: [DataWi]
//
//}
//
//// MARK: - Datum
//struct DataWi: Codable {
//    let hotelID: String
//    let imgURL: String
//    let hotelName, hotelAddress: String
//    let hotelRatings: Int
//    let isOnWhishList: Bool
//    let bookingPrice: Int
//    let discountPrice: String
//    let media: [MediaWish]
//
//    enum CodingKeys: String, CodingKey {
//        case hotelID
//        case imgURL = "imgUrl"
//        case hotelName, hotelAddress, hotelRatings, isOnWhishList, bookingPrice, discountPrice, media
//    }
//}
//
//// MARK: - Media
//struct MediaWish: Codable {
//    let id: Int
//    let sid, itemType: String
//    let url: String
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, sid
//        case itemType = "item_type"
//        case url
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//
//// MARK: - Welcome
//struct WishListData: Codable {
//    let statusCode: Int
//    let success: Bool
//    let message: String
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClassWishlist: Codable {
//    let whishList: [WhishList]
//
//    enum CodingKeys: String, CodingKey {
//        case whishList = "whish_list"
//    }
//}

// MARK: - Welcome
struct WishListData: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
    let data: DataClassWishlist
}

// MARK: - DataClass
struct DataClassWishlist: Codable {
    let whishList: [DataWi]

    enum CodingKeys: String, CodingKey {
        case whishList = "whish_list"
    }
}

// MARK: - WhishList
struct DataWi: Codable {
    let hotelID: String
    let imgURL: String
    let hotelName, hotelAddress: String
    let hotelRatings: Int
    let isOnWhishList: Bool
    let bookingPrice, discountPrice: Int
    let media: [MediaWish]
    let amenities: [AmenityWish]

    enum CodingKeys: String, CodingKey {
        case hotelID
        case imgURL = "imgUrl"
        case hotelName, hotelAddress, hotelRatings, isOnWhishList, bookingPrice, discountPrice, media, amenities
    }
}

// MARK: - Amenity
struct AmenityWish: Codable {
    let amenitiesName: String
    let amenitiesImg: String

    enum CodingKeys: String, CodingKey {
        case amenitiesName = "amenities_name"
        case amenitiesImg = "amenities_img"
    }
}

// MARK: - Media
struct MediaWish: Codable {
    let id: Int
    let sid, itemType: String
    let url: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, sid
        case itemType = "item_type"
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
