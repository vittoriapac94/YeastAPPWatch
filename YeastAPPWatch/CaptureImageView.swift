//
//  CaptureImageView.swift
//  SimpleImageClassifier
//
//  Created by Michele Di Capua on 04/06/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import Foundation
import SwiftUI

struct CaptureImageView
{
    /// TODO 2: Implement other things later
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var uiimage: UIImage?
    
    
    func makeCoordinator() -> Coordinator
    {
        return Coordinator(isShown: $isShown, image: $image, uiimage: $uiimage)
    }
}


extension CaptureImageView: UIViewControllerRepresentable
{
    func makeUIViewController
    (context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController
    {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        


        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>)
    {
        
    }
}

struct CaptureImageView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
