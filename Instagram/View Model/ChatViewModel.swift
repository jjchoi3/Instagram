//
//  ChatViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/20/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class ChatViewModel : ObservableObject{
    @Published var composedMessage: String = ""
    var image: Image = Image(IMAGE_PHOTO)
    var imageData: Data = Data()
    var errorString = ""
    
    @Published var showImagePicker: Bool = false
    @Published var showAlert: Bool = false
    
    @Published var chats: [Chat] = []
    @Published var isLoading = false
    var recipientId = ""
    var listener: ListenerRegistration!
    
    func loadChats(){
        self.chats = []
        self.isLoading = true
        
        Api.Chat.getChatMessages(withUser: recipientId, onSuccess: { (chats) in
            if self.chats.isEmpty{
                self.chats = chats
            }
        }, onError: { (errorMessage) in
            
        }, newChat: { (chat) in
            if !self.chats.isEmpty {
                self.chats.append(chat)
            }
        }) { (listener) in
            self.listener = listener
        }
    }
    
    func sendTextMessage(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void, onError: @escaping(_ errorMessage: String)->Void){
        if !composedMessage.isEmpty{
            Api.Chat.sendMessages(message: composedMessage, recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, onSuccess: completed, onError: onError)
        }
    }
    func sendPhotoMessage(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void, onError: @escaping(_ errorMessage: String)->Void){
        if !imageData.isEmpty{
            Api.Chat.sendPhotoMessages(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, imageData: imageData, onSuccess: completed, onError: onError)
        }
    }
}
