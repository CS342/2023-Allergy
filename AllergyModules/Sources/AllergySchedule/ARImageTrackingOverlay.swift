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
            .onChange(of: image) { newImage in
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
                    if xCoord >= centerCoordX - 50 && xCoord <= centerCoordX + 50 && yCoord >= centerCoordY - 50 && yCoord <= centerCoordY + 50 {
                        takeScreenshot = true
                        
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
