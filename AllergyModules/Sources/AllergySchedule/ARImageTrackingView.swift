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


class ARImageTrackingViewCoordinator: NSObject, ARSCNViewDelegate {
    let image: Binding<ImageState>
    let presentationMode: Binding<PresentationMode>
    weak var sceneView: ARSCNView?
    
    
    init(image: Binding<ImageState>, presentationMode: Binding<PresentationMode>) {
        self.image = image
        self.presentationMode = presentationMode
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        let referenceImage = imageAnchor.referenceImage
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(
                width: referenceImage.physicalSize.width,
                height: referenceImage.physicalSize.height
            )
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            
            // `SCNPlane` is vertically oriented in its local coordinate space, but `ARImageAnchor` assumes the image
            // is horizontal in its local space, so rotate the plane to match.
            planeNode.eulerAngles.x = -.pi / 2
            
            // Image anchors are not tracked after initial detection, so create an animation that limits the duration
            // for which the plane visualization appears.
            planeNode.runAction(
                .sequence(
                    [
                        .wait(duration: 0.25),
                        .fadeOpacity(to: 0.85, duration: 0.25),
                        .fadeOpacity(to: 0.15, duration: 0.25),
                        .fadeOpacity(to: 0.85, duration: 0.25),
                        .fadeOut(duration: 0.5),
                        .removeFromParentNode()
                    ]
                ),
                completionHandler: {
                    // If the image anchor is still available after we run the animation we take a screenshot.
                    if imageAnchor.isTracked {
                        self.createScreenshot()
                    }
                }
            )
            
            // Add the plane visualization to the scene.
            node.addChildNode(planeNode)
        }
    }
    
    
    private func createScreenshot() {
        Task { @MainActor in
            guard let screenshot = sceneView?.snapshot() else {
                return
            }
            
            self.image.wrappedValue = .success(screenshot)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct ARImageTrackingView: UIViewRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var image: ImageState
    
    
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        let configuration = ARWorldTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: .main) else {
            fatalError("Could not load the reference images from the asset catalogue (\"AR Resources\")")
        }
        
        configuration.detectionImages = referenceImages
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.delegate = context.coordinator
        
        context.coordinator.sceneView = sceneView
        
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> ARImageTrackingViewCoordinator {
        ARImageTrackingViewCoordinator(image: $image, presentationMode: presentationMode)
    }
}