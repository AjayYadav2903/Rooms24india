//
//  Conversation.swift
//  AirVting
//
//  Created by Apple on 8/9/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Conversation {
    var _id = ""
    var title = ""
    var sender = UserModel()
    var receivers = [UserModel]()
    var messages = [ConversationDetail]()
    var unreadCount = 0
    init(json: JSON) {
        _id = json["_id"].string ?? ""
        title = json["title"].string ?? ""
        sender = UserModel(json: json["sender"])
        /*if let receiversArr = json["receiver"].array {
            for receiver in receiversArr {
                let user = UserModel(json: receiver)
                receivers.append(user)
            }
        }*/ // commented because server responde only one receiver, not array
        let receiver = UserModel(json: json["receiver"])
        receivers.append(receiver)
        
        if let messagesArr = json["messages"].array {
            for msg in messagesArr {
                let message = ConversationDetail(json: msg)
                messages.append(message)
            }
        }
        
        unreadCount = json["unReadCount"].int ?? 0
    }
}


class ConversationDetail {
    var content = ""
    var isRead = false
    var createdAt = ""
    var updatedAt = ""
    var senderId = ""
    var timeAgo = ""
    
    
    init() {
    }
    
    init(json: JSON) {
        content = json["content"].string ?? ""
        isRead = json["isRead"].bool ?? false
        createdAt = json["createdAt"].string ?? ""
        updatedAt = json["updatedAt"].string ?? ""
        senderId = json["senderId"].string ?? ""
        timeAgo = (createdAt.dateValue?.getElapsedInterval() as AnyObject).lowercased ?? ""
    }
    
    func updateTimeAgo() {
        timeAgo = (createdAt.dateValue?.getElapsedInterval() as AnyObject).lowercased ?? ""
    }
}
