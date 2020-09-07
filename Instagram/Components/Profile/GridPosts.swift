//
//  GridPosts.swift
//  Instagram
//
//  Created by Junho Choi on 6/18/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage
struct GridPosts: View {
    
    var splitted: [[Post]] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 1){
            //Rows
            ForEach(0..<splitted.count){ index in
                HStack(spacing: 1){
                    //Columns
                    ForEach(self.splitted[index], id:\.postId) { post in
                        
                        URLImage(URL(string: post.mediaUrl)!,
                                 content: {
                                    $0.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                        }).frame(width: UIScreen.main.bounds.width/3, height:UIScreen.main.bounds.width/3).clipped()
                        
                    }
                }
            }
        }
    }
}

