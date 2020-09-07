//
//  ContentView.swift
//  Instagram
//
//  Created by Junho Choi on 6/11/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct SigninView: View {
    
    //Text Binding
    //@State allows rerendering + displays content to user
    //@Binding
    @ObservedObject var signinViewModel = SigninViewModel()
    
    
    func signIn(){
        signinViewModel.signIn(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            print(user.email)
            self.clean()
        }) { (errorMessage) in
            print("Error \(errorMessage)")
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func clean(){
        self.signinViewModel.email = ""
        self.signinViewModel.password = ""
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                HeaderView()
                Spacer()
                Divider()
                EmailTextField(email : $signinViewModel.email)
                PasswordTextField(password: $signinViewModel.password)
                SigninButton(action: signIn, label: TEXT_SIGN_IN).alert(isPresented: $signinViewModel.showAlert){
                    Alert(title: Text("Error"), message: Text(self.signinViewModel.errorString), dismissButton: .default(Text("OK")))
                }
                Divider()
                NavigationLink(destination: SignupView()){
                    SignupText()
                }
            }
        }.accentColor(Color.black) //Color of navigation bar
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}



