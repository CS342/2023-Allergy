//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var overlayImageView = UIImageView(image: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video)
        else {
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)
        else {
            return
        }
        
        captureSession.addInput(input)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        // Add the image overlay
        let overlayImage = UIImage(named: "human-arm")
        overlayImageView.image = overlayImage
        overlayImageView.contentMode = .scaleAspectFill
        overlayImageView.frame = view.bounds
        view.addSubview(overlayImageView)
    }
}
