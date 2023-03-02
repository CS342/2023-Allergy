//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseStorage


struct GalleryViewList: View {
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]
    static let storage = Storage.storage().reference()
    let storageReference = storage.child("files")

    

       var body: some View {
           ScrollView(.horizontal) {
               LazyHGrid(rows: rows) {
                   ForEach(0x1f600...0x1f679, id: \.self) { value in
                       Text(String(format: "%x", value))
                       Text(emoji(value))
                           .font(.largeTitle)
                   }
               }
           }
       }

       private func emoji(_ value: Int) -> String {
           guard let scalar = UnicodeScalar(value) else { return "?" }
           return String(Character(scalar))
       }
}

struct GalleryViewList_Previews: PreviewProvider {
    static var previews: some View {
        GalleryViewList()
    }
}
