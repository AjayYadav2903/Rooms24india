//
//  Place.swift
//  AirVting
//
//  Created by SeiLK on 8/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Place {
    var description = ""
    var place_id = ""
    init(json: JSON) {
        description = json["description"].string ?? ""
        place_id = json["place_id"].string ?? ""
    }
}
