//
//  Post.swift
//  Instagram
//
//  Created by Junho Choi on 6/17/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation

struct Post: Encodable, Decodable {
    var caption: String
    var likes: [String: Bool]
    var location: String
    var ownerId: String
    var postId: String
    var username: String
    var avatar: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
}

