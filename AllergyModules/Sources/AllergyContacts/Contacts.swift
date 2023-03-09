//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Contact
import Foundation
import SwiftUI


/// Displays the contacts for the CS342 2023 Allergy Team Application.
public struct Contacts: View {
    public var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                InstructionView()
            }
            .navigationTitle(String(localized: "CONTACTS_NAVIGATION_TITLE", bundle: .module))
        }
    }
    
    public init() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}


struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts()
    }
}
