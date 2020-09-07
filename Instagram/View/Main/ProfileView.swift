//
//  Profile.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage
import FirebaseAuth
struct ProfileView: View {
    //Access session
    @EnvironmentObject var session: SessionStore
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State var selection: Selection = .grid
    
    var body: some View {
        return
            NavigationView{
            ScrollView{
                VStack(alignment:.leading, spacing: 15){
                    ProfileHeader(user: self.session.userSession, postCount: profileViewModel.posts.count, followingCount: $profileViewModel.followingCountState, followersCount: $profileViewModel.followersCountState)
                    EditProfileButton()
                    ProfileInformation(user: self.session.userSession)
                    
                   //Segmented controller
                   Picker(selection: $selection, label: Text("Grid or Table")){
                    ForEach(Selection.allCases){ selection in
                        selection.image.tag(selection)
                    }
                   }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 10).padding(.trailing, 10)
                   
                    //Display photos
                    if !profileViewModel.isLoading{
                        if selection == .grid{ //Grid view
                            GridPosts(splitted: self.profileViewModel.splitted)
                        }else{ //Table view
                            ForEach(self.profileViewModel.posts, id: \.postId) { post in
                                VStack {
                                    HeaderCell(post: post)
                                    FooterCell(post: post)
                                }
                            }
                        }
                    }
                }.padding(.top, 20)
                }.navigationBarTitle(Text("Profile"), displayMode: .inline).navigationBarItems(leading:
                    Button(action: {}) {
                        NavigationLink(destination: UsersView()){
                            Image(systemName: "person.fill").imageScale(Image.Scale.large).foregroundColor(.black)
                        }
                    }, trailing:
                    Button(action: {
                        self.session.logout()
                    }) {
                    Image(systemName: "arrow.right.circle.fill").imageScale(Image.Scale.large).foregroundColor(.black)
            }).onAppear {
                //Updates whenever view is displayed
                self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

