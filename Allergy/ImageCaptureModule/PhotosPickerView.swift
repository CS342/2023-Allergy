//
//  PhotosPickerView.swift
//  Allergy
//
//  Created by Stanley Yang on 2/20/23.
//

import Photos
import SwiftUI
import PhotosUI

// Code implemented here https://www.appcoda.com/swiftui-photospicker

struct PhotosPickerView: View {
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Label("Select a photo", systemImage: "photo")
            }
            
            }
        }
    }
    




