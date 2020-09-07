//
//  UserApi.swift
//  Instagram
//
//  Created by Junho Choi on 6/16/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import FirebaseAuth
class UserApi{
    func searchUsers(text: String, onSuccess: @escaping(_ user: [User]) -> Void){
        Ref.FIRESTORE_COLLECTION_USERS.whereField("keywords", arrayContains: text.lowercased()).getDocuments{ (snapshot, error) in
            guard let snap = snapshot else{
                print("Error fetching data")
                return
            }
            var users = [User]()
            for document in snap.documents{
                let dict = document.data()
                guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                //Avoid showing the user
                if decoderUser.uid != Auth.auth().currentUser!.uid{
                    users.append(decoderUser)
                }
                
            }
            onSuccess(users)
        }
    }
    
    func loadPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void){
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").getDocuments{ (snapshot, error) in
            
            guard let snap = snapshot else{
                print("Error fetching data")
                return
            }
            
            var posts = [Post]()
            for document in snap.documents{
                let dict = document.data()
                guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                posts.append(decoderPost)
            }
            onSuccess(posts)
        }
    }
    
}

