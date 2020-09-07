//
//  NotificationView.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
import URLImage
struct NotificationView: View {
    @ObservedObject var activityViewModel = ActivityViewModel()
    
    var body: some View {
        
        NavigationView{
            List{
                if !activityViewModel.activities.isEmpty{
                    ForEach(self.activityViewModel.activities, id: \.activityId){ activity in
                       HStack{
                        if activity.type == "comment"{
                            ZStack{
                                ActivityRow(activity: activity)
                                NavigationLink(destination: CommentView(postId: activity.postId)){
                                    EmptyView()
                                }
                            }
                        }else{
                            ActivityRow(activity: activity)
                        }
                     }.padding(10)
                   }
                }
            }.navigationBarTitle(Text("Activity"), displayMode: .inline)
            .onAppear{
             self.activityViewModel.loadActivities()
            }.onDisappear{
                //Removes listeners when no longer viewing timeline display
                if self.activityViewModel.listener != nil{
                    self.activityViewModel.listener.remove()
                }
            }
        }
    }
}

struct ActivityRow: View{
    var activity: Activity!
    var body: some View{
        HStack{
            URLImage(URL(string: activity.userAvatar)!,
             content: {
                 $0.image
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .clipShape(Circle())
             }).frame(width: 50, height:50)
            VStack(alignment: .leading, spacing: 5){
             Text(activity.username).font(.subheadline).bold()
             Text(activity.typeDescription).font(.subheadline)
           }
           Spacer()
         Text(timeAgoSinceDate(Date(timeIntervalSince1970:  activity.date), currentDate: Date(), numericDates: true)).bold().font(.caption).foregroundColor(.gray)
        }
    }
}
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
