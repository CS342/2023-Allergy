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


class GalleryLister {
    static let shared = GalleryLister()
    //var initializedEmulator = false
    
    
    func listImages(subfolder: String) -> Array<UIImage?> {
        var imagesList: Array<UIImage?> = Array()
        let id = UUID().uuidString
        let storage = Storage.storage()
        
//        if !initializedEmulator && FeatureFlags.useFirebaseEmulator {
//            storage.useEmulator(withHost: "localhost", port: 9199)
//            initializedEmulator = true
//        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("Uploading image without user authenticated ...")
        }
        
        let storageRef = storage.reference().child("users/\(userId)/\(subfolder)")
        //let metadata = StorageMetadata()
        //metadata.contentType = "image/jpg"
        
        storageRef.listAll{ (result, error) in
            if let error = error {
                print("Error while retrieving file: ", error)
            }

            for item in result!.items {
                let pictureRef = storageRef.child(item.name)
                pictureRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Error while retrieving file: ", error)
                    } else {
                        let image = UIImage(data: data!)
                        imagesList.append(image)
                    }
                }
            }
        }
        return imagesList
    }
}
