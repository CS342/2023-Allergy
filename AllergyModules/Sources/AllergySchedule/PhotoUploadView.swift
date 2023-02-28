//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct PhotoUploadView: View {
    let photoUploadContext: PhotoUploadContext
    var body: some View {
        CameraView()
    }
}

struct PhotoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadView(photoUploadContext: PhotoUploadContext.base)
    }
}
