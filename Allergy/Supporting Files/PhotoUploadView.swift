//
//  PhotoUploadView.swift
//  TemplateApplication
//
//  Created by Vishnu Ravi on 2/1/23.
//

import FirebaseCore
import FirebaseStorage
import PhotosUI
import SwiftUI

struct PhotoUploadView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showImageSheet = false

    var body: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo to analyze!")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                            showImageSheet.toggle()
                        }
                    }
                }
                .sheet(isPresented: self.$showImageSheet) {
                    PhotoPreview(selectedImageData: $selectedImageData)
                }
        }.navigationTitle("Analyze Photo")
    }
}

struct PhotoPreview: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedImageData: Data?

    var body: some View {
        if let selectedImageData = self.selectedImageData,
           let uiImage = UIImage(data: selectedImageData) {
            VStack {
                Text("Photo Preview")
                    .font(.largeTitle)
                    .padding()
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding()
                Button("Upload + Analyze") {
                    StorageManager.shared.uploadImage(selectedImageData)
                    dismiss()
                }.buttonStyle(.borderedProminent)
            }.padding()
        }
    }
}

struct PhotoUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadView()
    }
}
