//
//  UsernameTextField.swift
//  Instagram
//
//  Created by Junho Choi on 6/12/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct UsernameTextField: View {
    @Binding var username: String
    
    var body: some View {
        HStack{
            Image(systemName:"person.fill").foregroundColor(Color(red:0,green:0,blue: 0, opacity: 0.3))
            TextField(TEXT_USERNAME, text: $username)
            }.modifier(TextFieldModifier())
    }
}
