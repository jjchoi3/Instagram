//
//  SearchView.swift
//  Instagram
//
//  Created by Junho Choi on 6/14/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct Photo: Identifiable{
    let id = UUID() //Gives each photo unique ID based on data
    var photo = ""
}

struct SearchView: View {
    
    @ObservedObject var postPopularViewModel = PostPopularViewModel()
    
    @State var selection: Selection = .grid
    var body: some View {
        return
            NavigationView{
            ScrollView{
            
                //Segmented controller
                Picker(selection: $selection, label: Text("Grid or Table")){
                    ForEach(Selection.allCases){ selection in
                        selection.image.tag(selection)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 10).padding(.trailing, 10).padding(.top)
                if !postPopularViewModel.isLoading{
                        if selection == .grid{ //Grid view
                            GridPosts(splitted: self.postPopularViewModel.splitted)
                        }else{ //Table view
                            ForEach(self.postPopularViewModel.posts, id: \.postId) { post in
                            VStack {
                                HeaderCell(post: post)
                                FooterCell(post: post)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Discover"), displayMode: .inline).onAppear {
                self.postPopularViewModel.loadPostPopular()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
