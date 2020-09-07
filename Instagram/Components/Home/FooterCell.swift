//
//  FooterCell.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage

struct FooterCell: View{
    @ObservedObject var footerCellViewModel = FooterCellViewModel()
    
    init(post: Post){
        self.footerCellViewModel.post = post
        self.footerCellViewModel.checkPostLiked()
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Image(systemName: (self.footerCellViewModel.isLiked) ? "heart.fill" : "heart").foregroundColor((self.footerCellViewModel.isLiked) ? .red : .black).onTapGesture {
                    if self.footerCellViewModel.isLiked{
                        self.footerCellViewModel.unlike()
                    }else{
                        self.footerCellViewModel.like()
                    }
                }
                NavigationLink(destination: CommentView(post: self.footerCellViewModel.post)){
                    Image(systemName: "bubble.left").renderingMode(.original)
                }
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark.fill")
            }.padding(.trailing, 15).padding(.leading, 15)
            
            if footerCellViewModel.post.likeCount > 0 {
                Text("\(footerCellViewModel.post.likeCount) \(self.footerCellViewModel.post.likeCount > 1 ? "likes" : "like")").font(.caption).foregroundColor(.gray).padding(.leading, 15).padding(.top, 5)
            }
            
            HStack{
                Text(self.footerCellViewModel.post.username).font(.subheadline).bold()
                Text(self.footerCellViewModel.post.caption).font(.subheadline)
            }.padding(.leading, 15)
            NavigationLink(destination: CommentView(post: self.footerCellViewModel.post)){
                Text("View all comments").font(.caption).foregroundColor(.gray).padding(.leading, 15)
            }
            HStack{
                URLImage(URL(string: self.footerCellViewModel.post.avatar)!,
                content: {
                    $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                })
                .frame(width: 25, height:25)
                Text("Add a comment...").font(.caption).foregroundColor(.gray)
                Spacer()
                Text("❤️")
                Text("👏")
                Image(systemName: "plus.circle").foregroundColor(.gray)
            }.padding(.trailing, 15).padding(.leading, 15)
            
            Text(timeAgoSinceDate(Date(timeIntervalSince1970: self.footerCellViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray).padding(.leading, 15)
        }
    }
}
