//
//  ImagePicker.swift
//  Instagram
//
//  Created by Junho Choi on 6/12/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var showImagePicker: Bool
    @Binding var pickedImage: Image
    @Binding var imageData: Data
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->  UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker //Returns controller of photo library
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        return
    }
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator.init(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        var parentImagePicker: ImagePicker
        
        init(_ imagePicker: ImagePicker){
            self.parentImagePicker = imagePicker //Points to ImagePicker
        }
        
        //User picked photo
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            parentImagePicker.pickedImage = Image(uiImage: uiImage)
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5){
                parentImagePicker.imageData = mediaData
                print(parentImagePicker.imageData)
            }
            parentImagePicker.showImagePicker = false
        }
        
        //User closed photo library
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parentImagePicker.showImagePicker = false
        }
        
    }
}
