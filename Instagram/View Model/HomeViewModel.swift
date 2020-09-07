//
//  HomeViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/19/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class HomeViewModel: ObservableObject{
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var listener: ListenerRegistration!
    
    //init(){
    //    loadTimeline()
    //}
    func loadTimeline(){
        self.posts = []
        isLoading = true
        
        Api.Post.loadTimeline(onSuccess: { (posts) in
            self.isLoading = false
            if self.posts.isEmpty{
                self.posts = posts
            }
        }, newPost:{(post) in
            if !self.posts.isEmpty{
                self.posts.insert(post, at:0) //Must insert at top, not end
            }
        },  deletePost:{(post) in
            if !self.posts.isEmpty{
                for(index, p) in self.posts.enumerated(){
                    if p.postId == post.postId{
                        self.posts.remove(at: index)
                    }
                }
            }
            
        }) { (listener) in
            self.listener = listener
        }
    }
}

