//
//  SwiftUIView.swift
//  
//
//  Created by Paul Shmiedmayer on 3/8/23.
//

import ImageSource
import SwiftUI


struct ARImageTrackingOverlay: View {
    @State var imageCoordindates: [CGPoint] = []
    @State var takeScreenshot = false
    @Binding var image: ImageState
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack {
            Button("Dismiss") {
                dismiss()
            }
            ARImageTrackingView(image: $image, takeScreenshot: $takeScreenshot, imageCoordindates: $imageCoordindates)
                .overlay {
                    ZStack(alignment: .topLeading) {
                        ForEach(imageCoordindates, id: \.debugDescription)
                        { imageCoordinate in
                            Text("KEEP PHONE STILL FOR 3 SECONDS")
                                .foregroundColor(.red)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                                .position(x: 200, y: 50)
                        }
                    }
                }
        }
            .onChange(of: image) { newImage in
                if newImage != .empty {
                    dismiss()
                }
            }
            .onChange(of: imageCoordindates) { newImageCoordindates in
                guard !newImageCoordindates.isEmpty else {
                    return
                }
                // Call this when you want to take a screenshot:
                // takeScreenshot = true
            }
    }
}

struct ARImageTrackingOverlay_Previews: PreviewProvider {
    @State private static var imageState: ImageState = .empty
    
    
    static var previews: some View {
        ARImageTrackingOverlay(image: $imageState)
    }
}
