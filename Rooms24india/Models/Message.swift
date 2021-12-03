//
//  Message.swift
//  AirVting
//
//  Created by Thanh Gieng on 8/9/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class Message: Decodable {
    var name: String! = nil
    var content: String! = nil
    var isIncoming: Bool? = true
    var user_img: String! = nil
    var user_name: String! = nil

    
    var post_id_fk: String! = nil
    var author_id_fk: String! = nil
    var author_id: String! = nil
    var created_at: String! = nil
    var message: String! = nil
    var comment: String! = nil
    var forum_id: String! = nil

    
}


