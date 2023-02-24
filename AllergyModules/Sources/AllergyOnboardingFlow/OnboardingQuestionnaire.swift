//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergySharedContext
import FHIR
import Onboarding
import Questionnaires
import SwiftUI


struct OnboardingQuestionnaire: View {
    @Binding var onboardingSteps: [OnboardingFlow.Step]
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    var onboardingQuestionnaire: Questionnaire {
        Bundle.module.questionnaire(withName: "AllergenTesting")
    }
    
    
    var body: some View {
        QuestionnaireView(questionnaire: onboardingQuestionnaire) {_ in
            completedOnboardingFlow = true
        }
    }
    
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
}


struct OnboardingQuestionnaire_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        OnboardingQuestionnaire(onboardingSteps: $path)
    }
}
