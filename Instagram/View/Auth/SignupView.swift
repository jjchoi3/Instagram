//
//  SignupView.swift
//  Instagram
//
//  Created by Junho Choi on 6/12/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
struct SignupView: View {
    @ObservedObject var signupViewModel = SignupViewModel()
    
    
    func signUp(){
        signupViewModel.signUp(username: signupViewModel.username, email: signupViewModel.email, password: signupViewModel.password, imageData: signupViewModel.imageData, completed: { (user) in
            self.clean()
            //Switch to Main App
        }) { (errorMessage) in
            print("Error \(errorMessage)")
            self.signupViewModel.showAlert = true
            self.signupViewModel.errorString = errorMessage
            self.clean()
        }
        
    }
    
    func clean(){
        self.signupViewModel.email = ""
        self.signupViewModel.username = ""
        self.signupViewModel.password = ""
    }
    
    var body: some View {
        VStack {
            signupViewModel.image.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipShape(Circle()).padding(.bottom, 80)
                .onTapGesture{
                    print("Tapped")
                    self.signupViewModel.showImagePicker = true
            }
            UsernameTextField(username: $signupViewModel.username)
            EmailTextField(email: $signupViewModel.email)
            VStack(alignment: .leading){
                PasswordTextField(password: $signupViewModel.password)
                Text(TEXT_SIGNUP_PASSWORD_REQUIRED).font(.footnote).foregroundColor(.gray).padding(.leading)
            }
            SignupButton(action:signUp, label: TEXT_SIGN_UP).alert(isPresented: $signupViewModel.showAlert){
                Alert(title: Text("Error"), message: Text(self.signupViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            Divider()
            Text(TEXT_SIGNUP_NOTE).font(.footnote).foregroundColor(.gray).padding().fixedSize(horizontal: false, vertical: true)
        }.sheet(isPresented: $signupViewModel.showImagePicker){ //If true, show ImagePicker controller
            ImagePicker(showImagePicker: self.$signupViewModel.showImagePicker, pickedImage: self.$signupViewModel.image, imageData: self.$signupViewModel.imageData)
        }.navigationBarTitle("Register", displayMode: .inline)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
