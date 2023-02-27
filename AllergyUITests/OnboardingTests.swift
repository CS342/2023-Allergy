//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//


import XCTest
import XCTestExtensions
import XCTHealthKit


class OnboardingTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        try disablePasswordAutofill()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "Allergy")
    }
    
    
    func testOnboardingFlow() throws {
        let app = XCUIApplication()
        
                try app.navigateOnboardingFlow()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.buttons["Schedule"].waitForExistence(timeout: 2))
        XCTAssertTrue(tabBar.buttons["Contacts"].waitForExistence(timeout: 2))
        XCTAssertTrue(tabBar.buttons["Mock Upload"].waitForExistence(timeout: 2))
    }
}


extension XCUIApplication {
    func conductOnboardingIfNeeded() throws {
        if self.staticTexts["CardinalKit\nAllergy Application"].waitForExistence(timeout: 2) {
            try navigateOnboardingFlow()
        }
    }
    
    func navigateOnboardingFlow() throws {
        try navigateOnboardingFlowWelcome()
        if staticTexts["User Consent Form"].waitForExistence(timeout: 5) {
            try navigateOnboardingFlowConsent()
        }
        try navigateOnboardingAccount()
        
    }
    
    private func navigateOnboardingFlowWelcome() throws {
        XCTAssertTrue(staticTexts["Allergy Patch Testing"].waitForExistence(timeout: 2))
        /*XCTAssertTrue(
         staticTexts["This is an all in one platform where you can upload pictures of your patch tests so your dermatologist can have instant access."]
         .waitForExistence(timeout: 0.5)
         )*/
        
        XCTAssertTrue(staticTexts["User Registration & Consent"].waitForExistence(timeout: 2))
        /*XCTAssertTrue(
         staticTexts["This app is HIPAA-compliant, and we will ask for consent for your personal information and access to images, as well as register you with our system."]
         .waitForExistence(timeout: 0.5)
         )*/
        
        XCTAssertTrue(staticTexts["Patient Survey"].waitForExistence(timeout: 2))
        /*XCTAssertTrue(
         staticTexts["You will need to take a survey regarding your medical history, symptoms, and other important information about your eczema."]
         .waitForExistence(timeout: 0.5)
         )*/
        
        XCTAssertTrue(staticTexts["Take Pictures"].waitForExistence(timeout: 2))
        /*XCTAssertTrue(
         staticTexts["Our platform allows you to effortlessly and securely take pictures of your patch test, from which your results and information can be processed by your dermatologist."]
         .waitForExistence(timeout: 0.5)
         )*/
        
        XCTAssertTrue(buttons["Register"].waitForExistence(timeout: 2))
        buttons["Register"].tap()
    }
    
    
    private func navigateOnboardingFlowConsent() throws {
        XCTAssertTrue(staticTexts["User Consent Form"].waitForExistence(timeout: 2))
        XCTAssertTrue(
            staticTexts["Please read through the following consent document before proceeding."]
                .waitForExistence(timeout: 2)
        )
        
        
        XCTAssertTrue(staticTexts["Given Name"].waitForExistence(timeout: 2))
        staticTexts["Given Name"].tap()
        textFields["Enter your given name ..."].typeText("Leland")
        
        XCTAssertTrue(staticTexts["Family Name"].waitForExistence(timeout: 2))
        staticTexts["Family Name"].tap()
        textFields["Enter your family name ..."].typeText("Stanford")
        
        staticTexts["Given Name"].swipeUp()
        
        XCTAssertTrue(staticTexts["Leland Stanford"].waitForExistence(timeout: 2))
        staticTexts["Leland Stanford"].firstMatch.swipeUp()
        
        XCTAssertTrue(buttons["I Consent"].waitForExistence(timeout: 2))
        buttons["I Consent"].tap()
    }
    
    
    private func navigateOnboardingAccount() throws {
        XCTAssertTrue(staticTexts["Your Account"].waitForExistence(timeout: 2))
        
        guard !buttons["Next"].waitForExistence(timeout: 5) else {
            buttons["Next"].tap()
            return
        }
        
        XCTAssertTrue(buttons["Sign Up"].waitForExistence(timeout: 2))
        buttons["Sign Up"].tap()
        
        XCTAssertTrue(navigationBars.staticTexts["Sign Up"].waitForExistence(timeout: 2))
        XCTAssertTrue(images["App Icon"].waitForExistence(timeout: 2))
        XCTAssertTrue(buttons["Email and Password"].waitForExistence(timeout: 2))
        
        buttons["Email and Password"].tap()
        
        try textFields["Enter your email ..."].enter(value: "leland@stanford.edu")
        swipeUp()
        
        secureTextFields["Enter your password ..."].tap()
        secureTextFields["Enter your password ..."].typeText("StanfordRocks")
        swipeUp()
        secureTextFields["Repeat your password ..."].tap()
        secureTextFields["Repeat your password ..."].typeText("StanfordRocks")
        swipeUp()
        
        try textFields["Enter your given name ..."].enter(value: "Leland")
        staticTexts["Repeat\nPassword"].swipeUp()
        
        try textFields["Enter your family name ..."].enter(value: "Stanford")
        staticTexts["Repeat\nPassword"].swipeUp()
        
        collectionViews.buttons["Sign Up"].tap()
        
        sleep(3)
        
        if staticTexts["HealthKit Access"].waitForExistence(timeout: 5) && navigationBars.buttons["Back"].waitForExistence(timeout: 5) {
            navigationBars.buttons["Back"].tap()
            
            XCTAssertTrue(staticTexts["Leland Stanford"].waitForExistence(timeout: 2))
            XCTAssertTrue(staticTexts["leland@stanford.edu"].waitForExistence(timeout: 2))
            XCTAssertTrue(scrollViews.otherElements.buttons["Next"].waitForExistence(timeout: 2))
            scrollViews.otherElements.buttons["Next"].tap()
        }
    }

}
