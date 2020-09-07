//
//  CommentView.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentViewModel = CommentViewModel()
    
    var post: Post?
    var postId: String?
    
    var body: some View {
        VStack{
            ScrollView{
                if !commentViewModel.comments.isEmpty{
                    ForEach(commentViewModel.comments){ comment in
                        CommentRow(comment: comment).padding(.bottom, 10)
                    }
                }
            }
            CommentInput(post: post, postId: postId)
        }.padding(.top, 15)
         .onAppear{
            self.commentViewModel.postId = self.post == nil ? self.postId : self.post?.postId
            self.commentViewModel.loadComments()
        }.onDisappear{
            //Removes listeners when no longer viewing comments display
            if self.commentViewModel.listener != nil{
                self.commentViewModel.listener.remove()
            }
        }
    }
}
