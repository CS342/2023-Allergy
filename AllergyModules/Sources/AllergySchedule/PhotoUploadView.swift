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
    @State var comment: String = ""
    let photoUploadContext: PhotoUploadContext
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationStack {
            VStack {
                Text(String(localized: "PHOTO_UPLOAD_INSTRUCTION", bundle: .module))
                    .padding()
                AllergyImageSource(image: $image)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                TextField("Enter a comment (optional)", text: $comment)
                    .padding()
                    .border(.blue)
                Button("Upload") {
                    guard let image,
                          let data = image.jpegData(compressionQuality: 0.4) else {
                        return
                    }

                    StorageManager.shared.uploadImage(data, subfolder: photoUploadContext.rawValue, comment: comment)
                    presentationMode.wrappedValue.dismiss()
                }
                    .disabled(image == nil)
            }
            .navigationTitle("\(photoUploadContext.rawValue.uppercased()) Photo Upload")
        }
    }
}

struct PhotoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadView(photoUploadContext: PhotoUploadContext.base)
    }
}
