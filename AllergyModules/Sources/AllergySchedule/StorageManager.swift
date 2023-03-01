//
//  StorageManager.swift
//  TemplateApplication
//
//  Created by Vishnu Ravi on 2/2/23.
//

import FirebaseCore
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    var initializedEmulator = false
    
    func uploadImage(_ data: Data) {
        let id = UUID().uuidString
        let storage = Storage.storage()
        if (!initializedEmulator) {
            storage.useEmulator(withHost: "localhost", port: 9199)
            initializedEmulator = true
        }
        let storageRef = storage.reference().child("\(id).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        storageRef.putData(data, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error while uploading file: ", error)
            }

            if let metadata = metadata {
                print("Metadata: ", metadata)
            }
        }
    }
}
