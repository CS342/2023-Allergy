//
//  SwiftUIView.swift
//  
//
//  Created by Sherry X. on 2/23/23.
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
