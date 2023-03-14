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
    @ObservedObject var galleryLister = GalleryLister()
    
    let rows = [GridItem(.fixed(100))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(Array(galleryLister.images.values.enumerated()), id: \.offset) { image in
                    NavigationLink(destination: IndividualPhotoView(photo: image.element)) {
                        Image(uiImage: image.element)
                            .resizable()
                            .scaledToFit()
                            .accessibilityLabel(Text("\(photoUploadContext.rawValue)-\(image.offset)"))
                            .frame(width: 100)
                    }
                }
            }
        }
        .task {
            galleryLister.listImages(subfolder: photoUploadContext.rawValue)
        }
    }
}
