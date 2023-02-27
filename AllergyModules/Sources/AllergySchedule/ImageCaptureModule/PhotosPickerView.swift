//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Photos
import PhotosUI
import SwiftUI

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
    
