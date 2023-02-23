//
//  CameraOverlayView.swift
//  Allergy
//
//  Created by Sonya Jin on 2/22/23.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var overlayImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
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
