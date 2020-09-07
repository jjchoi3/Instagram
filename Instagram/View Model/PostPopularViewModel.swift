//
//  PostPopularViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/19/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI

class PostPopularViewModel: ObservableObject{
    @Published var posts: [Post] = []
    @Published var isLoading = false
    
    var splitted : [[Post]] = []
    
    func loadPostPopular(){
        isLoading = true
        Api.Post.loadPosts(){ (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into:3)
        }
    }
}

