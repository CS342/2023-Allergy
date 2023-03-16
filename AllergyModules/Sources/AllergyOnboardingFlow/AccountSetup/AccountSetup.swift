//
// This source file is part of the Stanford CardinalKit Allergy Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Account
import AllergySharedContext
import class FHIR.FHIR
import FirebaseAccount
import FirebaseAuth
import FirebaseFirestore
import Onboarding
import SwiftUI


struct AccountSetup: View {
    @Binding private var onboardingSteps: [OnboardingFlow.Step]
    @EnvironmentObject var account: Account
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    var body: some View {
        OnboardingView(
            contentView: {
                VStack {
                    OnboardingTitleView(
                        title: "ACCOUNT_TITLE".moduleLocalized,
                        subtitle: "ACCOUNT_SUBTITLE".moduleLocalized
                    )
                    Spacer(minLength: 0)
                    accountImage
                    accountDescription
                    Spacer(minLength: 0)
                }
            }, actionView: {
                actionView
            }
        )
            .onReceive(account.objectWillChange) {
                if account.signedIn {
                    if let user = Auth.auth().currentUser {
                        let uid = user.uid
                        let name = user.displayName?.components(separatedBy: " ")
                        let firstName = name?[0] ?? ""
                        let lastName = name?[1] ?? ""
                        let data: [String: Any] = ["firstName": firstName, "id": uid, "lastName": lastName]
                        Firestore.firestore().collection("users").document(uid).setData(data) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            }
                        }
                    }
                    
                    completedOnboardingFlow = true
                }
            }
    }
    
    @ViewBuilder
    private var accountImage: some View {
        Group {
            if account.signedIn {
                Image(systemName: "person.badge.shield.checkmark.fill")
            } else {
                Image(systemName: "person.fill.badge.plus")
            }
        }
            .font(.system(size: 150))
            .foregroundColor(.accentColor)
    }
    
    @ViewBuilder
    private var accountDescription: some View {
        VStack {
            Group {
                if account.signedIn {
                    Text("ACCOUNT_SIGNED_IN_DESCRIPTION", bundle: .module)
                } else {
                    Text("ACCOUNT_SETUP_DESCRIPTION", bundle: .module)
                }
            }
                .multilineTextAlignment(.center)
                .padding(.vertical, 16)
            if account.signedIn {
                UserView()
                    .padding()
                Button("Logout", role: .destructive) {
                    try? Auth.auth().signOut()
                }
            }
        }
    }
    
    @ViewBuilder
    private var actionView: some View {
        if account.signedIn {
            OnboardingActionsView(
                "ACCOUNT_NEXT".moduleLocalized,
                action: {
                    completedOnboardingFlow = true
                }
            )
        } else {
            OnboardingActionsView(
                primaryText: "ACCOUNT_SIGN_UP".moduleLocalized,
                primaryAction: {
                    onboardingSteps.append(.signUp)
                },
                secondaryText: "ACCOUNT_LOGIN".moduleLocalized,
                secondaryAction: {
                    onboardingSteps.append(.login)
                }
            )
        }
    }
    
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
}


#if DEBUG
struct AccountSetup_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        AccountSetup(onboardingSteps: $path)
            .environmentObject(Account(accountServices: []))
            .environmentObject(FirebaseAccountConfiguration<FHIR>(emulatorSettings: (host: "localhost", port: 9099)))
    }
}
#endif
