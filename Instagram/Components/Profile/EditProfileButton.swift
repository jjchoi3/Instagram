//
//  EditProfileButton.swift
//  Instagram
//
//  Created by Junho Choi on 6/18/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct EditProfileButton: View {
    var body: some View {
        Button(action: {}) {
            HStack{
                Spacer()
                Text("Edit Profile").fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }.frame(height:30).background(Color.black)
        }.cornerRadius(5).padding(.leading, 20).padding(.trailing, 20)
    }
}

