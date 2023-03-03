//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import ARKit

struct ARImageTrackingView: UIViewRepresentable {

    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        let configuration = ARImageTrackingConfiguration()
        if let imageToTrack = ARReferenceImage("overlay") {
            configuration.trackingImages = [imageToTrack]
        }
        sceneView.session.run(configuration)
        sceneView.delegate = context.coordinator
        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSCNViewDelegate {

        func renderer(_ renderer: ARSCNView, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            // The image you are tracking has been detected
            let screenshot = renderer.snapshot()
            UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        }

    }

}
