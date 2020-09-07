//
//  ChatView.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    
    var recipientId = ""
    var recipientAvatarUrl = ""
    var recipientUsername = ""
    
    func sendTextMessage(){
        chatViewModel.sendTextMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            self.clean()
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func sendPhoto(){
        chatViewModel.sendPhotoMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
        }
    }
    
    func showPicker(){
        self.chatViewModel.showImagePicker = true
    }
    func clean(){
        self.chatViewModel.composedMessage = ""
    }
    
    var body: some View {
        VStack{
            ScrollView{
                if !chatViewModel.chats.isEmpty{
                    ForEach(chatViewModel.chats, id: \.messageId){ chat in
                        VStack(alignment: .leading){
                            if chat.isPhoto{
                                PhotoMessageRow(chat: chat)
                            }else if chat.isText{
                                TextMessageRow(chat: chat)
                            }
                        }.padding(.top, 20)
                    }
                }
            }
            
            HStack(spacing: 10){
                
                //Zstack overlays children objects
                ZStack{
                    RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1).padding()
                    HStack(spacing:10){
                        Button(action: {}){
                            Image(systemName: "camera.fill").padding(12).foregroundColor(.white).background(Color.blue).clipShape(Circle())
                        }.padding(.leading, 20)
                        TextField("Message...", text: $chatViewModel.composedMessage).padding(.top, 30).padding(.bottom, 30)
                        Button(action: showPicker){
                            Image(systemName: "photo").imageScale(.large).foregroundColor(.black)
                        }
                        Button(action: {}){
                        Image(systemName: "mic.fill").imageScale(.large).foregroundColor(.black)
                        }
                        Button(action: sendTextMessage){
                            Image(systemName: "paperplane").imageScale(.large).foregroundColor(.black).padding(.trailing, 30)
                        }
                    }
                }.frame(height: 60)
            }
        }.sheet(isPresented: $chatViewModel.showImagePicker, onDismiss: {
            self.sendPhoto()
        }){ //If true, show ImagePicker controller
            ImagePicker(showImagePicker: self.$chatViewModel.showImagePicker, pickedImage: self.$chatViewModel.image, imageData: self.$chatViewModel.imageData)
            
        }.navigationBarTitle(Text("Chat"), displayMode: .inline).alert(isPresented: $chatViewModel.showAlert){
            Alert(title: Text("Error"), message: Text(self.chatViewModel.errorString), dismissButton: .default(Text("OK")))
        }.onAppear{
            self.chatViewModel.recipientId = self.recipientId
            self.chatViewModel.loadChats()
        }.onDisappear{
            //Removes listeners when no longer viewing comments display
            if self.chatViewModel.listener != nil{
                self.chatViewModel.listener.remove()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

import URLImage

struct PhotoMessageRow: View{
    var chat: Chat!
    
    var body: some View{
        Group{
            if !chat.isCurrentUser{
                HStack(alignment: .top){
                    URLImage(URL(string: chat.avatarUrl)!,
                    content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    }).frame(width: 30, height: 30)
                    
                    URLImage(URL(string: chat.photoUrl)!,
                    content: {
                        $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    }).frame(width: 200, height: 200).cornerRadius(10)
                    Spacer()
                }.padding(.leading, 15)
            }else{
                HStack(){
                    Spacer()
                    URLImage(URL(string: chat.photoUrl)!,
                    content: {
                        $0.image
                        .resizable()
                        .scaledToFill()
                    }).frame(width: 200, height: 200).cornerRadius(10)
                }.padding(.trailing, 15)
            }
        }
    }
}

struct TextMessageRow: View{
    var chat: Chat!
    
    var body: some View{
        Group{
            if !chat.isCurrentUser {
            HStack(alignment: .top) {
                 URLImage(URL(string: chat.avatarUrl)!,
                 content: {
                     $0.image
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .clipShape(Circle())
                 }).frame(width: 30, height: 30).clipShape(Circle())
             Text(chat.textMessage).padding(10).foregroundColor(.black).background(Color(red: 237/255, green: 237/255, blue: 237/255)).cornerRadius(10).font(.callout)
             Spacer()
             }.padding(.leading, 15).padding(.trailing, 50)
            }else{
                 HStack(alignment: .top){
                       Spacer(minLength: 50)
                      Text(chat.textMessage).padding(10).foregroundColor(.white).background(Color.blue).cornerRadius(10).font(.callout)
                  }.padding(.trailing, 15)
            }
        }
    }
}
