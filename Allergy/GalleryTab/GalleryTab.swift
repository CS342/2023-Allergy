//
//  GalleryTab.swift
//  Allergy
//
//  Created by Andy Wang on 3/2/23.
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
