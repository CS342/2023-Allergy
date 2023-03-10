//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct IndividualPhotoView: View {
    var photo: UIImage?
    
    var body: some View {
        Image(uiImage: photo!)
            .resizable()
            .scaledToFit()
            .padding()
            .accessibilityHidden(true)
    }
}

// struct IndividualPhotoView_Previews: PreviewProvider {
//     static var previews: some View {
//         IndividualPhotoView()
//     }
// }
