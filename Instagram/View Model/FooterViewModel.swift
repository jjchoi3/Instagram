//
//  FooterViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/19/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage

class FooterCellViewModel: ObservableObject{
    @Published var post: Post!
    @Published var isLoading = false
    @Published var isLiked = false

    func checkPostLiked(){
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
    }
    
    func like(){
        post.likeCount += 1
        isLiked = true
        
        //Update database
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: post.ownerId).collection("userPosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : true,
                                                                                                                               "likeCount":post.likeCount])
        Ref.FIRESTORE_COLLECTION_ALL_POSTS.document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : true,
                                                                             "likeCount":post.likeCount])
        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: post.ownerId).collection("timelinePosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : true,
                                                                                                                                   "likeCount":post.likeCount])
        
        //Find followers and update posts in their timeline using Cloud function
        if Auth.auth().currentUser!.uid != post.ownerId{
            let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").document().documentID
            let activity = Activity(activityId: activityId, type: "like", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: post.postId, mediaUrl: post.mediaUrl, comment: "", date: Date().timeIntervalSince1970)
            guard let activityDict = try? activity.toDictionary() else {return}
            Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").document(activityId).setData(activityDict)
        }
    }
    
    func unlike(){
        post.likeCount -= 1
        isLiked = false
        
        //Update database
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: post.ownerId).collection("userPosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : false,
                                                                                                                               "likeCount":post.likeCount])
        Ref.FIRESTORE_COLLECTION_ALL_POSTS.document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : false,
                                                                             "likeCount":post.likeCount])
        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: post.ownerId).collection("timelinePosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : false,
                                                                                                                                   "likeCount":post.likeCount])
        
        if Auth.auth().currentUser!.uid != post.ownerId{
            Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").whereField("type", isEqualTo: "like").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).whereField("postId", isEqualTo: post.postId).getDocuments { (snapshot, error) in
                if let doc = snapshot?.documents{
                    if let data = doc.first, data.exists{
                        data.reference.delete()
                    }
                }
            }
        }
    }
}

