//
//  Coordinator.swift
//  SimpleImageClassifier
//
//  Created by Michele Di Capua on 04/06/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import Foundation
import SwiftUI
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
  @Binding var uiimageInCoordinator : UIImage?
  
    init(isShown: Binding<Bool>, image: Binding<Image?>, uiimage: Binding<UIImage?>)
  {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _uiimageInCoordinator = uiimage
  }
  
    
    func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else { return }
            
        uiimageInCoordinator = unwrapImage
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShown = false
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
     isCoordinatorShown = false
    }
}
