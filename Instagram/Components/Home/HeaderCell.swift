//
//  HeaderCell.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage
struct HeaderCell: View{
    var post: Post
    var body: some View{
        VStack{
            HStack{
                URLImage(URL(string: post.avatar)!,
                   content: {
                       $0.image
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .clipShape(Circle())
                   }).frame(width: 35, height:35)
                    VStack(alignment: .leading){
                        Text(post.username).bold()
                        Text("location").font(.caption)
                    }
                    Spacer()
                Image(systemName: "ellipsis")
                }.padding(.trailing, 15).padding(.leading, 15)
            
               URLImage(URL(string: post.mediaUrl)!,
                content: {
                    $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                }).frame(width: UIScreen.main.bounds.size.width, height:300).clipped()
            }
        }
}
