// swift-tools-version: 5.7

//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "AllergyModules",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AllergyContacts", targets: ["AllergyContacts"]),
        .library(name: "AllergyMockDataStorageProvider", targets: ["AllergyMockDataStorageProvider"]),
        .library(name: "AllergyOnboardingFlow", targets: ["AllergyOnboardingFlow"]),
        .library(name: "AllergySchedule", targets: ["AllergySchedule"]),
        .library(name: "AllergySharedContext", targets: ["AllergySharedContext"])
    ],
    dependencies: [
        .package(url: "https://github.com/StanfordBDHG/CardinalKit.git", .upToNextMinor(from: "0.3.0"))
    ],
    targets: [
        .target(
            name: "AllergyContacts",
            dependencies: [
                .target(name: "AllergySharedContext"),
                .product(name: "Contact", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "AllergyMockDataStorageProvider",
            dependencies: [
                .target(name: "AllergySharedContext"),
                .product(name: "CardinalKit", package: "CardinalKit"),
                .product(name: "FHIR", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "AllergyOnboardingFlow",
            dependencies: [
                .target(name: "AllergySharedContext"),
                .product(name: "Account", package: "CardinalKit"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "FirebaseAccount", package: "CardinalKit"),
                .product(name: "HealthKitDataSource", package: "CardinalKit"),
                .product(name: "Onboarding", package: "CardinalKit"),
                .product(name: "Views", package: "CardinalKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "AllergySchedule",
            dependencies: [
                .target(name: "AllergySharedContext"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "Questionnaires", package: "CardinalKit"),
                .product(name: "Scheduler", package: "CardinalKit")
            ]
        ),
        .target(
            name: "AllergySharedContext",
            dependencies: []
        )
    ]
)
