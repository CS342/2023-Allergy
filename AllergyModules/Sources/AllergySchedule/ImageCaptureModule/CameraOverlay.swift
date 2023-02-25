//
//  CameraOverlay.swift
//  
//
//  Created by Sonya Jin on 2/24/23.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var captureButton: UIButton!

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    var imagePicker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create overlayImageView
        let overlayImage = UIImage(named: "human-arm.png")
        let overlayImageView = UIImageView(image: overlayImage)
        overlayImageView.contentMode = .scaleAspectFill
        overlayImageView.alpha = 0.5
        previewView.addSubview(overlayImageView)


        // Set up the capture session
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo

        // Set up the video preview layer
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(videoPreviewLayer!)

        // Set up the image overlay
        overlayImageView.contentMode = .scaleAspectFill
        overlayImageView.alpha = 0.5

        // Set up the photo output
        photoOutput = AVCapturePhotoOutput()
        captureSession?.addOutput(photoOutput!)

        // Start the capture session
        captureSession?.startRunning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Adjust the video preview layer's frame to match the preview view's bounds
        videoPreviewLayer?.frame = previewView.bounds
    }

    @IBAction func capturePhoto(_ sender: UIButton) {
        // Disable the capture button while the photo is being taken
        captureButton.isEnabled = false

        // Capture a photo and process the image data
        let photoSettings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: photoSettings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }

        // Save the photo to the device's photo library
        guard let photoImage = UIImage(data: imageData) else {
            return
        }

        UIImageWriteToSavedPhotosAlbum(photoImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

        // Re-enable the capture button
        captureButton.isEnabled = true
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image to photo library: \(error.localizedDescription)")
        } else {
            print("Image saved to photo library successfully")
        }
    }
}
