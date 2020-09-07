//
//  SearchBar.swift
//  Instagram
//
//  Created by Junho Choi on 6/15/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI
struct SearchBar: UIViewRepresentable{
    @Binding var text: String
    var onSearchButtonChanged: (() -> Void)? = nil
    
    class Coordinator: NSObject, UISearchBarDelegate{
        let searchBarView: SearchBar
        init(_ searchBar: SearchBar){
            self.searchBarView = searchBar
        }
        
        //Tells the delegate that the user changed the search text
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            searchBarView.text = searchText
            searchBarView.onSearchButtonChanged?()
            
        }
        
        //Tells the delegate that the search button was tapped.
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBarView.onSearchButtonChanged?()
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator()-> Coordinator{
        return Coordinator(self)
    }
    
    // Creates a UIView instance to be presented
    func makeUIView(context: UIViewRepresentableContext<SearchBar>)-> UISearchBar{
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.delegate = context.coordinator
        
        return searchBar
    }
    
    //Updates the state of the specified view with new information from SwiftUI.
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>){
        uiView.text = self.text
    }
}
