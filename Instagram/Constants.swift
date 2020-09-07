//
//  Constants.swift
//  Instagram
//
//  Created by Junho Choi on 6/12/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


//Color Constants
let COLOR_LIGHT_GRAY = Color(red:0,green:0,blue: 0, opacity: 0.15)

//Main View
let APP_NAME = "Instagram"

//Sign in and Sign up pages
let TEXT_NEED_AN_ACCOUNT = "Don't have an account?"
let TEXT_SIGN_UP = "Sign up"
let TEXT_SIGN_IN = "Sign in"
let TEXT_USERNAME = "Username"
let TEXT_EMAIL = "Email"
let TEXT_PASSWORD = "Password"
let TEXT_SIGNIN_HEADLINE = "Photo Sharing"
let TEXT_SIGNIN_SUBHEADLINE = "The easiest way to share photos with friends and family"
let TEXT_SIGNUP_NOTE = "An account will allow you to save and access photo information across devices. You can delete your account at any time and your information will not be shared."
let TEXT_SIGNUP_PASSWORD_REQUIRED = "At least 8 characters required"

let IMAGE_LOGO = "logo"
let IMAGE_USER_PLACEHOLDER = "user-placeholder"

let IMAGE_PHOTO = "plus.circle"

//Reference to Firebase
class Ref{
    //Storage
    static var STORAGE_ROOT = Storage.storage().reference(forURL: "gs://instagram-e494d.appspot.com")
    
    //Storage Avatar
    static var STORAGE_AVATAR = STORAGE_ROOT.child("avatar")
    static func STORAGE_AVATAR_USERID(userId: String) -> StorageReference{
        return STORAGE_AVATAR.child(userId)
    }
    
    //Storage Posts
    static var STORAGE_POSTS = STORAGE_ROOT.child("posts")
    static func STORAGE_POST_ID(postId: String) -> StorageReference{
        return STORAGE_POSTS.child(postId)
    }
    //Storage Chat
    static var STORAGE_CHAT = STORAGE_ROOT.child("chat")
    static func STORAGE_CHAT_ID(chatId: String) -> StorageReference{
        return STORAGE_CHAT.child(chatId)
    }
    
    
    //Firestore
    static var FIRESTORE_ROOT = Firestore.firestore()
    
    //Firestore Users
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_DOCUMENT_USERID(userId: String) -> DocumentReference{
        return FIRESTORE_COLLECTION_USERS.document(userId)
    }
    
    //Firestore Posts
    static var FIRESTORE_COLLECTION_MY_POSTS = FIRESTORE_ROOT.collection("myPosts")
    static func FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: String) -> DocumentReference{
        return FIRESTORE_COLLECTION_MY_POSTS.document(userId)
    }
    
    //Firestore Timeline
    static var FIRESTORE_COLLECTION_TIMELINE = FIRESTORE_ROOT.collection("timeline")
    static func FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: String) -> DocumentReference{
        return FIRESTORE_COLLECTION_TIMELINE.document(userId)
    }
    
    //Firestore All Posts
    static var FIRESTORE_COLLECTION_ALL_POSTS = FIRESTORE_ROOT.collection("all_Posts")
    
    //Firestore Comments
    static var FIRESTORE_COLLECTION_COMMENTS = FIRESTORE_ROOT.collection("comments")
    static func FIRESTORE_COMMENTS_DOCUMENT_POSTID(postId: String) -> DocumentReference{
        return FIRESTORE_COLLECTION_COMMENTS.document(postId)
    }
    
    //Firestore Chat
    static var FIRESTORE_COLLECTION_CHAT = FIRESTORE_ROOT.collection("chat")
    static func FIRESTORE_COLLECTION_CHATROOM(senderId: String, recipientId: String) -> CollectionReference{
        return FIRESTORE_COLLECTION_CHAT.document(senderId).collection("chatRoom").document(recipientId).collection("chatItems")
    }
    
    //Firestore Message
   static var FIRESTORE_COLLECTION_INBOX_MESSAGES = FIRESTORE_ROOT.collection("messages")
   static func FIRESTORE_COLLECTION_INBOX_MESSAGES(userId: String) -> CollectionReference{
       return FIRESTORE_COLLECTION_INBOX_MESSAGES.document(userId).collection("inboxMessages")
   }
    static func FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: String, recipientId: String) -> DocumentReference{
        return FIRESTORE_COLLECTION_INBOX_MESSAGES.document(senderId).collection("inboxMessages").document(recipientId)
    }
    
    //Firestore Following
    static var FIRESTORE_COLLECTION_FOLLOWING = FIRESTORE_ROOT.collection("following")
    static func FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_FOLLOWING.document(Auth.auth().currentUser!.uid).collection("userFollowing").document(userId)
    }
    static func FIRESTORE_COLLECTION_FOLLOWING(userId: String) -> CollectionReference {
           return FIRESTORE_COLLECTION_FOLLOWING.document(userId).collection("userFollowing")
    }
    
    //Firestore Followers
    static var FIRESTORE_COLLECTION_FOLLOWERS = FIRESTORE_ROOT.collection("followers")
    static func FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: String) -> DocumentReference{
        return FIRESTORE_COLLECTION_FOLLOWERS.document(userId).collection("userFollowers").document(Auth.auth().currentUser!.uid)
    }
    static func FIRESTORE_COLLECTION_FOLLOWERS(userId: String) -> CollectionReference{
        return FIRESTORE_COLLECTION_FOLLOWERS.document(userId).collection("userFollowers")
    }
    
    //Firestore Activity
    static var FIRESTORE_COLLECTION_ACTIVITY = FIRESTORE_ROOT.collection("activity")
}
