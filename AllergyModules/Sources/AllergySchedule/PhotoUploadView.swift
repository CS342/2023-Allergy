//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import ImageSource
import SwiftUI


struct PhotoUploadView: View {
    @State var image: UIImage?
    let photoUploadContext: PhotoUploadContext
    
    
    var body: some View {
        NavigationStack {
            VStack {
                AllergyImageSource(image: $image)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                Button("Upload") {
                    guard let image,
                          let data = image.jpegData(compressionQuality: 0.8) else {
                        return
                    }
                    
                    StorageManager.shared.uploadImage(data, subfolder: photoUploadContext.rawValue)
                }
                    .disabled(image == nil)
            }
                .navigationTitle("Image Source Example")
        }
    }
}


struct PhotoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadView(photoUploadContext: PhotoUploadContext.base)
    }
}
