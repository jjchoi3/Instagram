//
//  SigninViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/13/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

class SigninViewModel : ObservableObject{
    var email: String = ""
    var password : String = ""
    
    var errorString = ""
    
    //Published property wrapper allows observed object to notify views that data has been updated
    @Published var showAlert: Bool = false
    
    func signIn(email: String, password:String, completed: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String)->Void){
        if !email.isEmpty && !password.isEmpty{
            AuthService.signInUser(email: email, password: password, onSuccess: completed, onError: onError)
        }else{
            showAlert = true
            errorString = "Please fill in all fields"
        }
        
    }
}
