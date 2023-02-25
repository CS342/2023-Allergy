//ImageTracking.swfit
//Created by Sonya Jin

import SwiftUI
import ARKit

struct ARImageTrackingView: UIViewRepresentable {

    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        let configuration = ARImageTrackingConfiguration()
        if let image = UIImage(named: "myImage") {
            let referenceImage = ARReferenceImage(image.cgImage!, orientation: .up, physicalWidth: image.size.width)
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

    class Coordinator: NSObject, ARSCNViewDelegate {

        func renderer(_ renderer: ARSCNView, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            // The image you are tracking has been detected
            let screenshot = renderer.snapshot()
            UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        }

    }

}

