//
//  Comments.swift
//  Tirade
//
//  Created by admin on 20/05/20.
//  Copyright © 2020 ajayyadav. All rights reserved.
//

import UIKit

class CommentsDict: Decodable {

    var status : Int?
    var message : String?
    var comments : [Comments]?
}

class Comments: Decodable {
    var user_id : String?
    var forum_id : String?
    var comment : String?
    var created_at : String?
    var name : String?
    var user_img : String?
}


