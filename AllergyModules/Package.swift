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
        .package(url: "https://github.com/StanfordBDHG/CardinalKit", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "10.5.0")),
        .package(url: "https://github.com/StanfordBDHG/ImageSource", .revisionItem("d6d035913d6becc602487aaeaa48a3b8a46afd32"))
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
                .product(name: "Questionnaires", package: "CardinalKit"),
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
                .product(name: "Scheduler", package: "CardinalKit"),
                .product(name: "ImageSource", package: "ImageSource"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk")
            ]
        ),
        .target(
            name: "AllergySharedContext",
            dependencies: []
        )
    ]
)
