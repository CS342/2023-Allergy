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
    private static let defaultSchedule = Schedule(
        start: Calendar.current.startOfDay(for: Date()),
        dateComponents: .init(hour: 0, minute: 1),
        end: .numberOfEvents(1)
    )
    
    private static let tasks = [
        Task(
            title: String(localized: "Patch Testing Questionnaire", bundle: .module),
            description: String(localized: "QUESTIONNAIRE_INSTRUCTION", bundle: .module),
            schedule: defaultSchedule,
            context: AllergyTaskContext.questionnaire(Bundle.module.questionnaire(withName: "AllergenTesting"))
        ),
        Task(
            title: String(localized: "Photo Taking Task #1", bundle: .module),
            description: String(localized: "TASK1_INSTRUCTION", bundle: .module),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.base)
        ),
        Task(
            title: String(localized: "Photo Taking Task #2", bundle: .module),
            description: String(localized: "TASK2_INSTRUCTION", bundle: .module),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.day0)
        ),
        Task(
            title: String(localized: "Photo Taking Task #3", bundle: .module),
            description: String(localized: "TASK3_INSTRUCTION", bundle: .module),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.day2)
        ),
        Task(
            title: String(localized: "Photo Taking Task #4", bundle: .module),
            description: String(localized: "TASK4_INSTRUCTION", bundle: .module),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.day4)
        ),
        Task(
            title: String(localized: "Optional Photo Taking Task", bundle: .module),
            description: String(localized: "OPTIONAL_TASK_INSTRUCTION", bundle: .module),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.optional)
        )
    ]
    
    
    /// Creates a default instance of the ``AllergyScheduler`` by scheduling the tasks listed below.
    public convenience init() {
        self.init(tasks: AllergyScheduler.tasks)
    }
}
