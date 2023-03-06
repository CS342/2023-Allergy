//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//


import AllergySchedule
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import Foundation
import SwiftUI


struct GalleryViewList: View {
    let photoUploadContext: PhotoUploadContext
    let storage = Storage.storage()
    @ObservedObject var galleryLister = GalleryLister()
    
    let rows = [GridItem(.fixed(100))]
    
       var body: some View {
           ScrollView(.horizontal) {
               LazyHGrid(rows: rows) {
                   ForEach(Array(galleryLister.images.values), id: \.self) { image in
                        Image(uiImage: image)
                           .resizable()
                           .scaledToFit()
                           .frame(width: 100)
                           .accessibility(hidden: true)
                   }
               }
           }
           .task {
               galleryLister.listImages(subfolder: photoUploadContext.rawValue)
           }
       }
}

struct GalleryViewList_Previews: PreviewProvider {
    static var previews: some View {
        GalleryViewList(photoUploadContext: .base)
    }
}
