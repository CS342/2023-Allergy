//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergyMockDataStorageProvider
import AllergySchedule
import AllergySharedContext
import CardinalKit
import FHIR
import FHIRToFirestoreAdapter
import FirebaseAccount
import class FirebaseFirestore.FirestoreSettings
import FirebaseStorage
import FirebaseConfiguration
import FirestoreDataStorage
import FirestoreStoragePrefixUserIdAdapter
import HealthKit
import HealthKitDataSource
import HealthKitToFHIRAdapter
import Questionnaires
import Scheduler
import SwiftUI


class AllergyAppDelegate: CardinalKitAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: FHIR()) {
            AllergyScheduler()
            if !FeatureFlags.disableFirebase {
                if FeatureFlags.useFirebaseEmulator {
                    FirebaseAccountConfiguration(emulatorSettings: (host: "localhost", port: 9099))
                } else {
                    FirebaseAccountConfiguration()
                }
                FirestoreStorage()
                firestore
            }
            if HKHealthStore.isHealthDataAvailable() {
                healthKit
            }
            QuestionnaireDataSource()
            MockDataStorageProvider()
        }
    }
    
    
    private var firestore: Firestore<FHIR> {
        let settings = FirestoreSettings()
        if FeatureFlags.useFirebaseEmulator {
            settings.host = "localhost:8080"
            settings.isPersistenceEnabled = false
            settings.isSSLEnabled = false
        }
        
        return Firestore(
            adapter: {
                FHIRToFirestoreAdapter()
                FirestoreStoragePrefixUserIdAdapter()
            },
            settings: settings
        )
    }
    
    
    private var healthKit: HealthKit<FHIR> {
        HealthKit {
            CollectSample(
                HKQuantityType(.stepCount),
                deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
            )
        } adapter: {
            HealthKitToFHIRAdapter()
        }
    }
}


class FirestoreStorage<ComponentStandard: Standard>: Component {
    @Dependency private var configureFirebaseApp: ConfigureFirebaseApp
    
    
    func configure() {
        let storage = Storage.storage()
        if FeatureFlags.useFirebaseEmulator {
            storage.useEmulator(withHost: "localhost", port: 9199)
        }
    }
}
