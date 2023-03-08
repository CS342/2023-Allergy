//
// This source file is part of the CS342 2023 Allergy Team Application project
// The source code is based on the Apple "Detecting Images in an AR Experience" example project.
// https://developer.apple.com/documentation/arkit/content_anchors/detecting_images_in_an_ar_experience
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import ARKit
import ImageSource
import SceneKit
import SwiftUI


struct ARImageTrackingView: UIViewRepresentable {
    @Binding var image: ImageState
    @Binding var takeScreenshot: Bool
    @Binding var imageCoordindates: [CGPoint]
    
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        let configuration = ARWorldTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: .main) else {
            fatalError("Could not load the reference images from the asset catalogue (\"AR Resources\")")
        }
        
        configuration.detectionImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 2
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.delegate = context.coordinator
        
        context.coordinator.sceneView = sceneView
        
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> ARImageTrackingViewCoordinator {
        ARImageTrackingViewCoordinator(image: $image, screenCoordinates: $imageCoordindates, takeScreenshot: $takeScreenshot)
    }
}
