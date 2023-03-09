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
            title: String(localized: "Allergy Task", bundle: .module),
            description: String(
                localized: """
                Patch testing can help identify substances that may cause an allergic reaction on the skin leading to contact dermatitis.
                Here are the steps to help you perform patch testing.
                """,
                bundle: .module
            ),
            schedule: defaultSchedule,
            context: AllergyTaskContext.questionnaire(Bundle.module.questionnaire(withName: "AllergenTesting"))
        ),
        Task(
            title: String(localized: "Photo Taking Task #1", bundle: .module),
            description: String(
                localized: "Identify healthy areas of your skin; on your arms, forearms, or thighs, free of any rashes, to apply each allergen panel and take a picture before applying the allergens.",
                bundle: .module
            ),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.base)
        ),
        Task(
            title: String(localized: "Photo Taking Task #2", bundle: .module),
            description: String(
                localized: "Follow the instructions on the package to apply the allergen panels on the areas of skin you have chosen and photographed earlier. Use the marking provided in the package to mark the skin around each panel and take a photo right after application.",
                bundle: .module
            ),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.day0)
        ),
        Task(
            title: String(localized: "Photo Taking Task #3", bundle: .module),
            description: String(
                localized: "After two days, remove the allergen panels, but keep the markings on the skin to allow monitoring of the reactions to the sites of each allergen and take a photo including th marking.",
                bundle: .module
            ),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.day2)
        ),
        Task(
            title: String(localized: "Photo Taking Task #4", bundle: .module),
            description: String(
                localized: "Take another set of photos two days after removing the allergens. At this point, after taking the images, removing the markings on your skin",
                bundle: .module
            ),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.day4)
        ),
        Task(
            title: String(localized: "Optional Photo Taking Task", bundle: .module),
            description: String(
                localized: "If there are any photos you think will help us with diagnosis, please upload them here.",
                bundle: .module
            ),
            schedule: defaultSchedule,
            context: AllergyTaskContext.photoUpload(PhotoUploadContext.optional)
        )
    ]
    
    
    /// Creates a default instance of the ``AllergyScheduler`` by scheduling the tasks listed below.
    public convenience init() {
        self.init(tasks: AllergyScheduler.tasks)
    }
}
