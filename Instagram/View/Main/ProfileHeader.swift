//
//  ProfileHeader.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage
struct ProfileHeader: View {
    var user: User?
    var postCount: Int
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    
    var body: some View {
        HStack{
            if user != nil{
                URLImage(URL(string: user!.profileImageUrl)!,
                    content: {
                        $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                    }).frame(width: 80, height:80).padding(.leading, 20)
                    Spacer()
                    VStack{
                        Text("\(postCount)").font(.headline)
                        Text("Posts").font(.subheadline)
                    }.padding(10)
                    VStack{
                        Text("\(followersCount)").font(.headline)
                        Text("Followers").font(.subheadline)
                    }.padding(10)
                    VStack{
                        Text("\(followingCount)").font(.headline)
                        Text("Following").font(.subheadline)
                    }.padding(10)
                    Spacer()
                }
            }
            
    }
}

//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader()
//    }
//}
