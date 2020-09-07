//
//  MessageViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/21/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class MessageViewModel : ObservableObject{
    
    @Published var inboxMessages: [InboxMessage] = [InboxMessage]()
    var listener: ListenerRegistration!
    
    init(){
        loadInboxMessages()
    }
    
    func loadInboxMessages(){
        self.inboxMessages = []
        
        Api.Chat.getInboxMessages(onSuccess: { (inboxMessages) in
            if self.inboxMessages.isEmpty{
                self.inboxMessages = inboxMessages
            }
        }, onError: { (errorMessage) in
       
        }, newInboxMessage: { (inboxMessage) in
            if !self.inboxMessages.isEmpty {
                self.inboxMessages.append(inboxMessage)
                
            }
        }) { (listener) in
            self.listener = listener
        }
    }
}
