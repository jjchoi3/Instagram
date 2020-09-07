//
//  SessionStore.swift
//  Instagram
//
//  Created by Junho Choi on 6/13/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import Combine
import FirebaseAuth


//Used to notify changes to other places
class SessionStore: ObservableObject {
    //Published notifies callers of isLoggedIn variable of any changes
    @Published var isLoggedIn = false
    var userSession: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState(){
        //Takes longer to run than self.isLoggedIn = true, so must be non-published var
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user{
                //print(user.email)
                
                //Store User session, nil if no such session
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
                firestoreUserId.getDocument { (document, error) in
                    if let dict = document?.data(){
                        guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                        self.userSession = decoderUser
                    }
                }
                self.isLoggedIn = true
            }else{
                print("User has logged out")
                self.isLoggedIn = false
                self.userSession = nil
            }
        })
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    //Stop listening for Auth changes
    func unbind(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit{
        unbind()
    }
}
