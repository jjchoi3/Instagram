//
//  HomeView.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView {
                Story()
                if !homeViewModel.isLoading{
                    ForEach(self.homeViewModel.posts, id: \.postId) { post in
                        VStack {
                            HeaderCell(post: post)
                            FooterCell(post: post)
                        }
                    }
                }
                }.navigationBarTitle(Text(APP_NAME), displayMode: .inline).navigationBarItems(trailing:
                    Button(action: {}) {
                        NavigationLink(destination: MessagesView()){
                            Image(systemName: "paperplane").imageScale(Image.Scale.medium).foregroundColor(.black)
                        }
                    })
                 .onAppear{
                    self.homeViewModel.loadTimeline()
               }.onDisappear{
                   //Removes listeners when no longer viewing timeline display
                    if self.homeViewModel.listener != nil{
                        self.homeViewModel.listener.remove()
                }
           }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


