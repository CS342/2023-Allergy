//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct PatchTestingView: View {
    var body: some View {
        patchImage
            .resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .clipShape(Rectangle())
            .frame(maxWidth: 350)
    }
    
    
    private var patchImage: Image {
        guard let imagePath = Bundle.module.path(forResource: "PatchTesting", ofType: "jpg"),
           let image = UIImage(contentsOfFile: imagePath) else {
            return Image(systemName: "person.fill")
        }
        
        return Image(uiImage: image)
    }
}

struct PatchTestinGView_Previews: PreviewProvider {
    static var previews: some View {
        PatchTestingView()
    }
}
