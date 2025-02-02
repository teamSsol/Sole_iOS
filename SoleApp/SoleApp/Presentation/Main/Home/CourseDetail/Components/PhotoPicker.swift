//
//  PhotoPicker.swift
//  SoleApp
//
//  Created by SUN on 2023/03/15.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Binding var isPresented: Bool
    let filter: PHPickerFilter
    var limit: Int // 0 == 'no limit'.
    let onComplete: ([PHPickerResult]) -> Void
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = filter
        configuration.selectionLimit = limit
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: PHPickerViewControllerDelegate {

       func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
         parent.onComplete(results)
         picker.dismiss(animated: true)
//           parent.isPresented = false
       }
         

       private let parent: PhotoPicker

       init(_ parent: PhotoPicker) {
         self.parent = parent
       }
     }

    
    typealias UIViewControllerType = PHPickerViewController
    
    static func convertToUIImageArray(fromResults results: [PHPickerResult], onComplete: @escaping ([UIImage]?, Error?) -> Void) {
        var images = [UIImage]()

        let dispatchGroup = DispatchGroup()

        for result in results {
          dispatchGroup.enter()
          let itemProvider = result.itemProvider
          if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (imageOrNil, errorOrNil) in
              if let error = errorOrNil {
                onComplete(nil, error)
                dispatchGroup.leave()
              }
              if let image = imageOrNil as? UIImage {
                images.append(image)
                dispatchGroup.leave()
              }
            }
          }
        }
        dispatchGroup.notify(queue: .main) {
          onComplete(images, nil)
        }
      }


}

