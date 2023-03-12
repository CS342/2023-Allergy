//
// This source file is part of the CS342 2023 Allergy Team Application project
// The source code is based on the Apple "Detecting Images in an AR Experience" example project.
// https://developer.apple.com/documentation/arkit/content_anchors/detecting_images_in_an_ar_experience
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//


import ImageSource
import SwiftUI

struct ARImageTrackingOverlay: View {
    @State var imageCoordindates: [CGPoint] = []
    @State var takeScreenshot = false
    @Binding var image: ImageState
    @Environment(\.dismiss) private var dismiss
    @State var startTime = Double(-1)
    @State var displayText = false

    var body: some View {
        VStack {
            Button("Dismiss") {
                dismiss()
            }
            ARImageTrackingView(image: $image, takeScreenshot: $takeScreenshot, imageCoordindates: $imageCoordindates)
                .overlay {
                    if displayText {
                        ZStack(alignment: .topLeading) {
                            Text("KEEP PHONE STILL FOR 3 SECONDS")
                                .foregroundColor(.blue)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 0)
                                        .background(Color.blue)
                                )
                                .overlay(Text("KEEP PHONE STILL FOR 3 SECONDS").foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 20))
                                .position(x: 200, y: 50)
                        }
                    }
                }
        } .onChange(of: image) { newImage in
                if newImage != .empty {
                    dismiss()
                }
                                }
        .onChange(of: imageCoordindates) { newImageCoordindates in
                guard !newImageCoordindates.isEmpty else {
                    return
                }
                let screenSize = UIScreen.main.bounds.size
                let centerCoordX = screenSize.width / 2
                let centerCoordY = screenSize.height / 2

                for coordinate in newImageCoordindates {
                    let xCoord = Double(coordinate.x)
                    let yCoord = Double(coordinate.y)
                    if xCoord >= centerCoordX - 100 && xCoord <= centerCoordX + 100 && yCoord >= centerCoordY - 100 && yCoord <= centerCoordY + 100 {
                        if startTime == -1.0 {
                            startTime = Date().timeIntervalSinceReferenceDate
                            displayText = true
                        } else {
                            if Date().timeIntervalSinceReferenceDate - startTime >= 3.0 {
                                takeScreenshot = true
                                startTime = -1.0
                            }
                        }
                    } else {
                        startTime = -1.0
                        displayText = false
                    }
                }
        }
    }
}

struct ARImageTrackingOverlay_Previews: PreviewProvider {
    @State private static var imageState: ImageState = .empty

    static var previews: some View {
        ARImageTrackingOverlay(image: $imageState)
    }
}
