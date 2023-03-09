//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct DayTwoView: View {
    var body: some View {
        DayTwoImage
            .resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .clipShape(Rectangle())
            .frame(maxWidth: 350)
    }
    
    
    private var DayTwoImage: Image {
        guard let imagePath = Bundle.module.path(forResource: "day2", ofType: "jpg"),
           let image = UIImage(contentsOfFile: imagePath) else {
            return Image(systemName: "person.fill")
        }
        
        // swiftlint:disable:next accessibility_label_for_image
        return Image(uiImage: image)
    }
}

struct DayTwoView_Previews: PreviewProvider {
    static var previews: some View {
        DayTwoView()
    }
}
