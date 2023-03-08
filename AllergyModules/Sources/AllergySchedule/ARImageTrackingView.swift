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
    var detectedImageCounter = 0
    //var maximumNumberOfTrackedImages: Int
    
    init(image: Binding<ImageState>, presentationMode: Binding<PresentationMode>) {
        self.image = image
        self.presentationMode = presentationMode
    }
    
    @objc
    func closeButtonTapped() {
        self.presentationMode.wrappedValue.dismiss()
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
                        .fadeOut(duration: 3),
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

extension ARImageTrackingViewCoordinator {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let frame = session.currentFrame else { return }
        let planeNode = SCNNode()
        // Filter the anchors to find the ones that are image anchors, use compactMap because it skips nils
        let imageAnchors = anchors.compactMap { $0 as? ARImageAnchor }
       
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: .main) else {
            fatalError("Could not load the reference images from the asset catalogue (\"AR Resources\")")
        }
        
        // Loop through the image anchors and check if any of them are tracking our reference image
        for imageAnchor in imageAnchors {
            if let referenceImage = imageAnchor.referenceImage, referenceImage.cgImage == self.referenceImage.cgImage {
                // Update the position and transform of the plane node to match the image anchor
                planeNode.position = SCNVector3(imageAnchor.transform.columns.3.x, imageAnchor.transform.columns.3.y, imageAnchor.transform.columns.3.z)
                planeNode.transform = SCNMatrix4(imageAnchor.transform)
                
                struct ARImageTrackingView: UIViewRepresentable {
                    @Environment(\.presentationMode) private var presentationMode
                    @Binding var image: ImageState
                    
                    func makeUIView(context: Context) -> ARSCNView {
                        let sceneView = ARSCNView()
                        let configuration = ARWorldTrackingConfiguration()
                        
                        
                        configuration.detectionImages = referenceImages
                        configuration.maximumNumberOfTrackedImages = 2
                        
                        
                        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
                        sceneView.delegate = context.coordinator
                        
                        context.coordinator.sceneView = sceneView
                        
                        // Add close button as an overlay on top of the ARSCNView
                        let closeButton = UIButton(type: .close)
                        closeButton.addTarget(context.coordinator, action: #selector(ARImageTrackingViewCoordinator.closeButtonTapped), for: .touchUpInside)
                        sceneView.addSubview(closeButton)
                        closeButton.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            closeButton.topAnchor.constraint(equalTo: sceneView.topAnchor, constant: 16),
                            closeButton.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -16)
                        ])
                        
                        return sceneView
                    }
                    
                    func updateUIView(_ uiView: ARSCNView, context: Context) {}
                    
                    func makeCoordinator() -> ARImageTrackingViewCoordinator {
                        ARImageTrackingViewCoordinator(image: $image, presentationMode: presentationMode)
                    }
                }
            }
        }
    }
}
