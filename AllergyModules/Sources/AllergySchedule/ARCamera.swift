import ImageSource
import SwiftUI


struct ARCamera: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var image: ImageState
    
    
    var body: some View {
        Text("AR View ..")
        Button("Dismiss ...") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ARCamera_Previews: PreviewProvider {
    @State private static var image: ImageState = .empty
    
    
    static var previews: some View {
        ARCamera(image: $image)
    }
}
