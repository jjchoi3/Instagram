//
//  SigninButton.swift
//  Instagram
//
//  Created by Junho Choi on 6/12/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI
struct SigninButton: View {
    var action: () -> Void
    var label: String
    
    var body: some View {
        Button(action: action) {
            HStack{
                Spacer()
                Text(label).fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }
        }.modifier(SigninButtonModifier())
    }
}
