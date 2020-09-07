//
//  ActivityViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/23/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class ActivityViewModel: ObservableObject{
    @Published var activities: [Activity] = []
    var listener: ListenerRegistration!
    var isLoading = false
    
    func loadActivities(){
        self.activities = []
        isLoading = true
        
        Api.Activity.loadActivities(onSuccess: { (activities) in
            self.isLoading = false
            if self.activities.isEmpty{
                self.activities = activities
            }
        }, newActivity: { (activity) in
            if !self.activities.isEmpty{
                self.activities.insert(activity, at:0) //Must insert at top, not end
            }
        }, deleteActivity: { (activity) in
             if !self.activities.isEmpty{
                           for(index, a) in self.activities.enumerated(){
                               if a.activityId == activity.activityId{
                                   self.activities.remove(at: index)
                               }
                           }
                       }
        }) { (listener) in
             self.listener = listener
        }
    }
}
