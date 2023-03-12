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

class ARImageTrackingViewCoordinator: NSObject {
    let image: Binding<ImageState>
    let screenCoordinates: Binding<[CGPoint]>
    let takeScreenshot: Binding<Bool>
    weak var sceneView: ARSCNView?
    var detectedImageCounter = 0
    var nodes: [SCNNode] = []

    init(image: Binding<ImageState>, screenCoordinates: Binding<[CGPoint]>, takeScreenshot: Binding<Bool>) {
        self.image = image
        self.screenCoordinates = screenCoordinates
        self.takeScreenshot = takeScreenshot
    }
}

extension ARImageTrackingViewCoordinator: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }

        nodes.append(node)

        let referenceImage = imageAnchor.referenceImage

        DispatchQueue.global(qos: .userInitiated).async { [] in
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
//                    // If the image anchor is still available after we run the animation we take a screenshot.
//                    if imageAnchor.isTracked {
//                        self.createScreenshot()
//                    }
                }
            )

            // Add the plane visualization to the scene.
            node.addChildNode(planeNode)
        }
    }

        func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
            nodes.removeAll(where: { $0 == node })
        }

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            var imageCoordindates: [CGPoint] = []
            for node in nodes {
                let screenCoordinate = renderer.projectPoint(node.position)
                imageCoordindates.append(CGPoint(x: Double(screenCoordinate.x), y: Double(screenCoordinate.y)))
            }
            screenCoordinates.wrappedValue = imageCoordindates

            if takeScreenshot.wrappedValue {
                createScreenshot()
                takeScreenshot.wrappedValue = false
            }
        }

        private func createScreenshot() {
            Task { @MainActor in
                guard let screenshot = sceneView?.snapshot() else {
                    return
                }

                self.image.wrappedValue = .success(screenshot)
            }
        }
    }
