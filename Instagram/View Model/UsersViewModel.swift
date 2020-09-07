//
//  UsersViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/16/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI

class UsersViewModel: ObservableObject{
    @Published var users: [User] = []
    @Published var isLoading = false
    var searchText: String = ""
    
    func searchTextDidChange(){
        isLoading = true
        Api.User.searchUsers(text: searchText.removeWhiteSpaces()) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
}
