//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import FHIR
import Questionnaires
import AllergySharedContext

struct OnboardingQuestionnaire: View {
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    var onboardingQuestionnaire: Questionnaire {
        Bundle.module.questionnaire(withName: "AllergenTesting")
    }
    var body: some View {
        QuestionnaireView(questionnaire: onboardingQuestionnaire) {_ in
            completedOnboardingFlow = true
        }
    }
}

struct OnboardingQuestionnaire_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingQuestionnaire()
    }
}
