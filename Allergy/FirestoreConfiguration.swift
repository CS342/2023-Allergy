//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergySharedContext
import CardinalKit
import FirebaseConfiguration
import FirebaseStorage


class FirestoreStorage<ComponentStandard: Standard>: Component {
     @Dependency private var configureFirebaseApp: ConfigureFirebaseApp


     func configure() {
         let storage = Storage.storage()
         if FeatureFlags.useFirebaseEmulator {
             storage.useEmulator(withHost: "localhost", port: 9199)
         }
     }
 }
