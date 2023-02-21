//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTHealthKit


class OnboardingTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "Allergy")
    }
    
    
    func testOnboardingFlow() throws {
        let app = XCUIApplication()
        
                try app.navigateOnboardingFlow()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.buttons["Schedule"].waitForExistence(timeout: 0.5))
        XCTAssertTrue(tabBar.buttons["Contacts"].waitForExistence(timeout: 0.5))
        XCTAssertTrue(tabBar.buttons["Mock Upload"].waitForExistence(timeout: 0.5))
    }
}


extension XCUIApplication {
    func conductOnboardingIfNeeded() throws {
        if self.staticTexts["CardinalKit\nAllergy Application"].waitForExistence(timeout: 0.5) {
            try navigateOnboardingFlow()
        }
    }
    
    func navigateOnboardingFlow() throws {
        try navigateOnboardingFlowWelcome()
        if staticTexts["User Consent Form"].waitForExistence(timeout: 0.5) {
            try navigateOnboardingFlowConsent()
        }
        
    }
    
    private func navigateOnboardingFlowWelcome() throws {
        XCTAssertTrue(staticTexts["Allergy Patch Testing"].waitForExistence(timeout: 0.5))
        /*XCTAssertTrue(
            staticTexts["This is an all in one platform where you can upload pictures of your patch tests so your dermatologist can have instant access."]
                .waitForExistence(timeout: 0.5)
        )*/
        
        XCTAssertTrue(staticTexts["User Registration & Consent"].waitForExistence(timeout: 0.5))
        /*XCTAssertTrue(
            staticTexts["This app is HIPAA-compliant, and we will ask for consent for your personal information and access to images, as well as register you with our system."]
                .waitForExistence(timeout: 0.5)
        )*/
        
        XCTAssertTrue(staticTexts["Patient Survey"].waitForExistence(timeout: 0.5))
        /*XCTAssertTrue(
            staticTexts["You will need to take a survey regarding your medical history, symptoms, and other important information about your eczema."]
                .waitForExistence(timeout: 0.5)
        )*/
        
        XCTAssertTrue(staticTexts["Take Pictures"].waitForExistence(timeout: 0.5))
        /*XCTAssertTrue(
            staticTexts["Our platform allows you to effortlessly and securely take pictures of your patch test, from which your results and information can be processed by your dermatologist."]
                .waitForExistence(timeout: 0.5)
        )*/
        
        XCTAssertTrue(buttons["Register"].waitForExistence(timeout: 0.5))
        buttons["Register"].tap()
    }
    
    
    private func navigateOnboardingFlowConsent() throws {
        XCTAssertTrue(staticTexts["User Consent Form"].waitForExistence(timeout: 0.5))
        XCTAssertTrue(
            staticTexts["Please read through the following consent document before proceeding."]
                .waitForExistence(timeout: 0.5)
        )
        
        
        XCTAssertTrue(staticTexts["Given Name"].waitForExistence(timeout: 0.5))
        staticTexts["Given Name"].tap()
        textFields["Enter your given name ..."].typeText("Leland")
        
        XCTAssertTrue(staticTexts["Family Name"].waitForExistence(timeout: 0.5))
        staticTexts["Family Name"].tap()
        textFields["Enter your family name ..."].typeText("Stanford")
        
        staticTexts["Given Name"].swipeUp()
        
        XCTAssertTrue(staticTexts["Leland Stanford"].waitForExistence(timeout: 0.5))
        staticTexts["Leland Stanford"].firstMatch.swipeUp()
        
        XCTAssertTrue(buttons["I Consent"].waitForExistence(timeout: 0.5))
        buttons["I Consent"].tap()
    }
}
