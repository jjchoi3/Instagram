//
//  Chat.swift
//  Instagram
//
//  Created by Junho Choi on 6/20/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Chat: Encodable, Decodable{
    var messageId: String
    var textMessage: String
    var avatarUrl: String
    var photoUrl: String
    var senderId: String
    var username: String
    var date: Double
    var type: String
    
    var isCurrentUser : Bool{
        return Auth.auth().currentUser!.uid == senderId
    }
    var isPhoto: Bool{
        return type == "PHOTO"
    }
    
    var isText: Bool{
           return type == "TEXT"
    }
}
