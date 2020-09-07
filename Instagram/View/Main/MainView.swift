//
//  MainView.swift
//  Instagram
//
//  Created by Junho Choi on 6/13/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    
    func logout(){
        session.logout()
    }
    
    var body: some View {
        TabView{
            HomeView().tabItem({
                Image(systemName: "house.fill")
            }).tag(0)
            SearchView().tabItem({
                Image(systemName: "magnifyingglass")
            }).tag(1)
            CameraView().tabItem({
                Image(systemName: "camera.viewfinder")
            }).tag(2)
            NotificationView().tabItem({
                Image(systemName: "heart.fill")
            }).tag(3)
            ProfileView().tabItem({
                Image(systemName: "person.fill")
            }).tag(4)
        }.accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
