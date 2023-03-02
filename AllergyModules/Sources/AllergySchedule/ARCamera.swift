import SwiftUI
import AVFoundation
import ImageSource

struct ARCamera: View {
    
    @State private var session = AVCaptureSession()
    @State private var imageState: ImageState = .empty
    
    var body: some View {
        ZStack {
            
            Camera(image: $imageState).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Image("overlay")
                .resizable()
                .scaledToFill()
                .frame(width: 1000, height: 400)
//            Image("blue-rectangle")
//                .resizable()
//                .scaledToFit()
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//            Image("human-arm")
//                .resizable()
//                .scaledToFit()
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
        }
        .onAppear {
            self.session = AVCaptureSession()
            self.session.beginConfiguration()
            
            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                fatalError("No video device found.")
            }
            
            do {
                let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
            
            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }
}

struct ARCamera_Previews: PreviewProvider {
    static var previews: some View {
        ARCamera()
    }
}
