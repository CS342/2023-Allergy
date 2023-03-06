//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergySchedule
import SwiftUI

struct GalleryTab: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(PhotoUploadContext.allCases, id: \.self) { photoUploadContext in
                    Section(header: Text(photoUploadContext.rawValue)) {
                        GalleryViewList(photoUploadContext: photoUploadContext)
                    }
                }
            }.navigationTitle("Gallery")
        }
    }
}

struct GalleryTab_Previews: PreviewProvider {
    static var previews: some View {
        GalleryTab()
    }
}
