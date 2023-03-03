//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AVFoundation
import ImageSource
import SwiftUI
struct CameraOverlay: View {
    @Binding var image: ImageState
    var body: some View {
        ZStack {
            Camera(image: $image).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Image("overlay")
                .resizable()
                .scaledToFill()
                .frame(width: 1000, height: 400)
                .accessibility(hidden: true)
        }
    }
}
