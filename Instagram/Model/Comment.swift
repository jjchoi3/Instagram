//
//  Comment.swift
//  Instagram
//
//  Created by Junho Choi on 6/19/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation

struct Comment: Encodable, Decodable, Identifiable {
    var id = UUID()
    var comment: String
    var avatarUrl: String
    var ownerId: String
    var postId: String
    var username: String
    var date: Double
}
