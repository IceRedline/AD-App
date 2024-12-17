//
//  ImagePicker.swift
//  My First App
//
//  Created by Артем Табенский on 23.03.2024.
//

import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
    func showImagePicker(in viewController: UIViewController, sourceType: UIImagePickerController.SourceType, completion: ((UIImage) -> ())?) {
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.sourceType = sourceType
        viewController.present(imagePickerController!, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

