//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergySharedContext
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import SwiftUI


class GalleryLister: ObservableObject {
    @Published var images: [String: UIImage] = [:]
    

    func listImages(subfolder: String) {
        let storage = Storage.storage()
        
        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("Uploading image without user authenticated ...")
        }
        
        let storageRef = storage.reference().child("users/\(userId)/\(subfolder)")
        
        storageRef.listAll { result, error in
            if let error = error {
                print("Error while retrieving file: ", error)
            }
            
            guard let result else {
                return
            }
            
            for item in result.items {
                let pictureRef = storageRef.child(item.name)
                pictureRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Error while retrieving file: ", error)
                    } else {
                        guard let data, let image = UIImage(data: data) else {
                            return
                        }
                        self.images[item.name] = image
                    }
                }
            }
        }
    }
}
