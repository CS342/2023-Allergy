//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import ARKit
import SwiftUI

struct ARImageTrackingView: UIViewRepresentable {
    class Coordinator: NSObject, ARSCNViewDelegate {
        private func renderer(_ renderer: ARSCNView, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARImageAnchor
            else {
                return
            }
            // The image you are tracking has been detected
            let screenshot = renderer.snapshot()
            UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        }
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        let configuration = ARImageTrackingConfiguration()
        if let image = UIImage(named: "overlay"),
           let cgImage = image.cgImage {
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: image.size.width)
            configuration.trackingImages = [referenceImage]
        }
        sceneView.session.run(configuration)
        sceneView.delegate = context.coordinator
        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}
