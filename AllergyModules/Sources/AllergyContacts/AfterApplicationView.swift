//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct AfterApplicationView: View {
    var body: some View {
        AfterApplicationImage
            .resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .clipShape(Rectangle())
            .frame(maxWidth: 350)
    }
    
    
    private var AfterApplicationImage: Image {
        guard let imagePath = Bundle.module.path(forResource: "AfterApplication", ofType: "jpg"),
           let image = UIImage(contentsOfFile: imagePath) else {
            return Image(systemName: "person.fill")
        }
        
        // swiftlint:disable:next accessibility_label_for_image
        return Image(uiImage: image)
    }
}

struct AfterApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        AfterApplicationView()
    }
}
