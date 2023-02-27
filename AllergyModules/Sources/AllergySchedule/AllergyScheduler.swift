//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FHIR
import Foundation
import Scheduler


/// A `Scheduler` using the `FHIR` standard as well as the ``AllergyTaskContext`` to schedule and manage tasks and events in the
/// CardinalKit Allergy Applciation.
public typealias AllergyScheduler = Scheduler<FHIR, AllergyTaskContext>


extension AllergyScheduler {
    /// Creates a default instance of the ``AllergyScheduler`` by scheduling the tasks listed below.
    public convenience init() {
        let schedule = Schedule(
            start: Calendar.current.startOfDay(for: Date()),
            dateComponents: .init(hour: 8, minute: 0),
            end: .numberOfEvents(1)
        )
        self.init(tasks: [
            Task(
                title: String(localized: "Allergy Task", bundle: .module),
                description: String(
                    localized: """
                    Please complete this allergen testing survey to tell us more about your
                    current skin conditions in preparation for your patch testing.
                    """,
                    bundle: .module
                ),
                schedule: schedule,
                context: AllergyTaskContext.questionnaire(Bundle.module.questionnaire(withName: "AllergenTesting"))
            ),
            Task(
                title: String(localized: "Photo Taking Task #1", bundle: .module),
                description: String(
                    localized: "Please take a photo of your arm before applying the patch test.",
                    bundle: .module
                ),
                schedule: schedule,
                context: AllergyTaskContext.photoUpload(PhotoUploadContext.base)
            ),
            Task(
                title: String(localized: "Photo Taking Task #2", bundle: .module),
                description: String(
                    localized: "Please take a photo of your arm right after applying the patch test.",
                    bundle: .module
                ),
                schedule: schedule,
                context: AllergyTaskContext.photoUpload(PhotoUploadContext.day0)
            ),
            Task(
                title: String(localized: "Photo Taking Task #3", bundle: .module),
                description: String(
                    localized: "Please take a photo of your arm two days after applying the patch test.",
                    bundle: .module
                ),
                schedule: schedule,
                context: AllergyTaskContext.photoUpload(PhotoUploadContext.day2)
            ),
            Task(
                title: String(localized: "Photo Taking Task #4", bundle: .module),
                description: String(
                    localized: "Please take a photo of your arm four days after applying the patch test.",
                    bundle: .module
                ),
                schedule: schedule,
                context: AllergyTaskContext.photoUpload(PhotoUploadContext.day4)
            )
        ])
    }
}
