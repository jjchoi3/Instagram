//
//  InitialView.swift
//  Instagram
//
//  Created by Junho Choi on 6/13/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    //Only needed to initialize once to use anywhere
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listenAuthenticationState()
    }
    
    var body: some View {
        Group{
            if session.isLoggedIn {
                MainView()
            }else{
                SigninView()
            }
        }.onAppear(perform: listen)
    }
}

