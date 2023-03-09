//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct BaselineView: View {
    var body: some View {
        BaselineImage
            .resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .clipShape(Rectangle())
            .frame(maxWidth: 350)
    }
    
    
    private var BaselineImage: Image {
        guard let imagePath = Bundle.module.path(forResource: "BaselineView", ofType: "jpg"),
           let image = UIImage(contentsOfFile: imagePath) else {
            return Image(systemName: "person.fill")
        }
        
        // swiftlint:disable:next accessibility_label_for_image
        return Image(uiImage: image)
    }
}

struct BaselineView_Previews: PreviewProvider {
    static var previews: some View {
        BaselineView()
    }
}
