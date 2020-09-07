//
//  SignupView.swift
//  Instagram
//
//  Created by Junho Choi on 6/12/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct SignupText: View {
    var body: some View {
        HStack{
            Text(TEXT_NEED_AN_ACCOUNT).font(.footnote).foregroundColor(.gray)
            Text(TEXT_SIGN_UP).foregroundColor(.gray)
        }
    }
}

