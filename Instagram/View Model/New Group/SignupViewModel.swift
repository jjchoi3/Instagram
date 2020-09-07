//
//  SignupViewModel.swift
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

class SignupViewModel : ObservableObject{
    var username: String = ""
    var email: String = ""
    var password : String = ""
    
    var errorString = ""
    
    var image: Image = Image(IMAGE_USER_PLACEHOLDER)
    var imageData: Data = Data() //Stores data form of image
    
    //Published property wrapper allows observed object to notify views that data has been updated
    @Published var showImagePicker: Bool = false
    @Published var showAlert: Bool = false
    
    func signUp(username: String, email: String, password:String, imageData: Data, completed: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String)->Void){
        if !username.isEmpty && !email.isEmpty && !password.isEmpty && !imageData.isEmpty{
            AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
        }else{
            showAlert = true
            errorString = "Please fill in all fields"
        }
        
    }
}
