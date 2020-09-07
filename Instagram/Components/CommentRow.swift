//
//  CommentRow.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage

struct CommentRow: View {
    var comment: Comment
    var body: some View {
         HStack{
               URLImage(URL(string: comment.avatarUrl)!,
               content: {
                   $0.image
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .clipShape(Circle())
               }).frame(width: 35, height:35)
               VStack(alignment: .leading){
                Text(comment.username).font(.subheadline).bold()
                Text(comment.comment).font(.caption).padding(.top, 5)
               }
               Spacer()
            Text(timeAgoSinceDate(Date(timeIntervalSince1970: comment.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray).padding(.leading, 15)
         }.padding(.trailing, 15).padding(.leading, 15)
    }
}
