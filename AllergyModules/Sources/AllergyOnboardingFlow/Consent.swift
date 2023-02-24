//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergySharedContext
import Onboarding
import SwiftUI


struct Consent: View {
    @Binding private var onboardingSteps: [OnboardingFlow.Step]
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    private var consentDocument: Data {
        guard let path = Bundle.module.url(forResource: "ConsentDocument", withExtension: "md"),
              let data = try? Data(contentsOf: path) else {
            return Data("CONSENT_LOADING_ERROR".moduleLocalized.utf8)
        }
        return data
    }
    
    var body: some View {
        ConsentView(
            header: {
                OnboardingTitleView(
                    title: "CONSENT_TITLE".moduleLocalized,
                    subtitle: "CONSENT_SUBTITLE".moduleLocalized
                )
            },
            asyncMarkdown: {
                consentDocument
            },
            action: {
                if !CommandLine.arguments.contains("--disableFirebase") {
                    onboardingSteps.append(.accountSetup)
                } else {
                    onboardingSteps.append(.healthKitPermissions)
                }
            }
        )
    }
    
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
}


struct Consent_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        Consent(onboardingSteps: $path)
    }
}
