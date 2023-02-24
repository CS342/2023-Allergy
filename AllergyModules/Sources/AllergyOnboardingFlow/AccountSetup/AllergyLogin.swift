//
// This source file is part of the Stanford CardinalKit Allergy Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Account
import Onboarding
import SwiftUI


struct AllergyLogin: View {
    var body: some View {
        Login {
            IconView()
                .padding(.top, 32)
            Text("LOGIN_SUBTITLE", bundle: .module)
                .multilineTextAlignment(.center)
                .padding()
                .padding()
            Spacer(minLength: 0)
        }
            .navigationBarTitleDisplayMode(.large)
    }
}


#if DEBUG
struct AllergyLogin_Previews: PreviewProvider {
    static var previews: some View {
        AllergyLogin()
            .environmentObject(Account(accountServices: []))
    }
}
#endif
