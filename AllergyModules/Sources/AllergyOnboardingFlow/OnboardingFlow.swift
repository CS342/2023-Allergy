//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergySharedContext
import SwiftUI


/// Displays an multi-step onboarding flow for the CS342 2023 Allergy Team Application.
public struct OnboardingFlow: View {
    enum Step: String, Codable {
        case consent
        case accountSetup
        case login
        case signUp
    }
    
    
    @SceneStorage(StorageKeys.onboardingFlowStep) private var onboardingSteps: [Step] = []
    
    
    public var body: some View {
        NavigationStack(path: $onboardingSteps) {
            Welcome(onboardingSteps: $onboardingSteps)
                .navigationDestination(for: Step.self) { onboardingStep in
                    switch onboardingStep {
                    case .consent:
                        Consent(onboardingSteps: $onboardingSteps)
                    case .accountSetup:
                        AccountSetup(onboardingSteps: $onboardingSteps)
                    case .login:
                        AllergyLogin()
                    case .signUp:
                        AllergySignUp()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    public init() {}
}


struct OnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
