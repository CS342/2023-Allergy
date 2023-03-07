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


class StorageManager {
    static let shared = StorageManager()
    var initializedEmulator = false
    
    
    func uploadImage(_ data: Data, subfolder: String, comment: String) {
        let id = UUID().uuidString
        let storage = Storage.storage()
        
        if !initializedEmulator && FeatureFlags.useFirebaseEmulator {
            storage.useEmulator(withHost: "localhost", port: 9199)
            initializedEmulator = true
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("Uploading image without user authenticated ...")
        }
        
        let storageRef = storage.reference().child("users/\(userId)/\(subfolder)/\(id).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        metadata.customMetadata = ["comment": comment]

        storageRef.putData(data, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error while uploading file: ", error)
            }

            if let metadata = metadata {
                print("Metadata: ", metadata)
            }
        }
    }
}
