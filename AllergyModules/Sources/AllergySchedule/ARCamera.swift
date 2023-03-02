import AVFoundation
import ImageSource
import SwiftUI
struct ARCamera: View {
    @Binding var imageState: ImageState
    var body: some View {
        ZStack {
            Camera(image: $imageState).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Image("overlay")
                .resizable()
                .scaledToFill()
                .frame(width: 1000, height: 400)
        }
    }
}
