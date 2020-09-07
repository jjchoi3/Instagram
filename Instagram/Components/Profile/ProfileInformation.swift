//
//  ProfileInformation.swift
//  Instagram
//
//  Created by Junho Choi on 6/18/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct ProfileInformation: View {
    var user: User?
    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            if user != nil{
                Text(user!.username).bold()
                    Text("IOS Developer")
                }
            }.padding(.leading, 20)
    }
}

