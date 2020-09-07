//
//  CameraViewModel.swift
//  Instagram
//
//  Created by Junho Choi on 6/16/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

class CameraViewModel : ObservableObject{
    var caption: String = ""
    var image: Image = Image(IMAGE_PHOTO)
    var imageData: Data = Data() //Stores data form of image
    var errorString = ""
    
    //Published property wrapper allows observed object to notify views that data has been updated
    @Published var showImagePicker: Bool = false
    @Published var showAlert: Bool = false
    
    func  sharePost(completed: @escaping() -> Void, onError: @escaping(_ errorMessage: String)->Void){
        if !caption.isEmpty && !imageData.isEmpty{
            Api.Post.uploadPost(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
        }else{
            showAlert = true
            errorString = "Please fill in all fields"
        }
        
    }
}
