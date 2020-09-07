//
//  InboxMessage.swift
//  Instagram
//
//  Created by Junho Choi on 6/20/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation

struct InboxMessage: Encodable, Decodable, Identifiable{
    var id = UUID()
    var lastMessage: String
    var username: String
    var type: String
    var date: Double
    var userId: String
    var avatarUrl: String
}
