//
//  HomeDetailsModel.swift
//  Rooms24india
//
//  Created by admin on 25/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
class HomeDetailsModel: NSObject {

}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct HotelDetail: Codable {
    let statusCode: Int
    let success: Bool
    let message: String
    let data: HomeDetailData
}

// MARK: - DataClass
struct HomeDetailData: Codable {
    let sid, hotelName, hotelDescription, hotelImage: String
    let rating: Double
    let bookingPrice, isPopular: Int
    let createdAt, updatedAt: String
    let deletedAt: JSONNull?
    let address: Address
    let media: [MediaData]
    let reviews: [Review]
    let amenities: [Amenity]
    let facilities: [Facilities]
    let rules_policies: [String]
    let discount: Int
    let rooms: [Room]


    
    let isInWhishList: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case sid
        case hotelName = "hotel_name"
        case hotelDescription = "hotel_description"
        case hotelImage = "hotel_image"
        case rating
        case bookingPrice = "booking_price"
        case discount = "discount"
        case isPopular = "is_popular"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case address, media, reviews, amenities,facilities,rules_policies
        case isInWhishList = "is_in_whish_list"
        case rooms
    }
}

// MARK: - Room
struct Room: Codable {
    let sid: String
    let numberOfRooms: Int
    let roomTitle, roomDescription: String
    let price, discount, numberOfAllowedPerson, adult: Int
    let child, status: Int
    let createdAt, updatedAt: String
    let media : [MediaData]

    enum CodingKeys: String, CodingKey {
        case sid
        case numberOfRooms = "number_of_rooms"
        case roomTitle = "room_title"
        case roomDescription = "description"
        case price, discount
        case numberOfAllowedPerson = "number_of_allowed_person"
        case adult, child, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case media

    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int
    let sid, street, city, state: String
    let country: String
    let postalCode: Int
    let createdAt, updatedAt: String
    let deletedAt: JSONNull?
    let latitude, longitude: Double
    enum CodingKeys: String, CodingKey {
        case id, sid, street, city, state, country, postalCode,latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

struct Facilities: Codable {
    let facility_name : String

    enum CodingKeys: String, CodingKey {
        case facility_name = "facility_name"
    }
}



// MARK: - Amenity
struct Amenity: Codable {
    let amenitiesName, amenitiesImg: String

    enum CodingKeys: String, CodingKey {
        case amenitiesName = "amenities_name"
        case amenitiesImg = "amenities_img"
    }
}

// MARK: - Media
struct MediaData: Codable {
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

// MARK: - Review
struct Review: Codable {
    let sid, personName, personImg: String
    let reviewRatings: Int
    let ratingTitle, reviewDescription, createdAt, updatedAt: String
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case sid
        case personName = "person_name"
        case personImg = "person_img"
        case reviewRatings = "review_ratings"
        case ratingTitle = "rating_title"
        case reviewDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

