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
                        self.detectedImageCounter += 1
                        if self.detectedImageCounter == 2 {
                            self.createScreenshot()
                            self.detectedImageCounter = 0
                        }
                    }
                }
            )
            let textLayer = CATextLayer()
            textLayer.string = "Keep phone still for next 3 seconds!"
            textLayer.fontSize = 24
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
            textLayer.frame = CGRect(x: 0, y: 50, width: 300, height: 50)
            let overlayNode = SCNNode()
            overlayNode.geometry = SCNPlane(width: 0.1, height: 0.1)
            overlayNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
            overlayNode.geometry?.firstMaterial?.lightingModel = .constant
            overlayNode.position = SCNVector3(0.0, 0.0, -0.5)

            overlayNode.geometry?.firstMaterial?.isDoubleSided = true
            overlayNode.geometry?.firstMaterial?.writesToDepthBuffer = false
            overlayNode.geometry?.firstMaterial?.readsFromDepthBuffer = false
            overlayNode.geometry?.firstMaterial?.transparency = 1.0
            overlayNode.geometry?.firstMaterial?.blendMode = .screen

            overlayNode.geometry?.firstMaterial?.emission.contents = textLayer

            node.addChildNode(overlayNode)
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
