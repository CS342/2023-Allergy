//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import AllergyTaskContext


struct GalleryViewList: View {
    let photoUploadContext: PhotoUploadContext
    let storage = Storage.storage()
    let images = GalleryLister.shared.listImages(subfolder: photoUploadContext.rawValue)
    
       var body: some View {
           ScrollView(.horizontal) {
               LazyHGrid(images: images) {
                   for pic in images {
                       UIImage(pic)
                   }
               }
           }.navigationTitle("Gallery")
       }

       private func emoji(_ value: Int) -> String {
           guard let scalar = UnicodeScalar(value) else { return "?" }
           return String(Character(scalar))
       }
}

struct GalleryViewList_Previews: PreviewProvider {
    static var previews: some View {
        GalleryViewList()
    }
}
