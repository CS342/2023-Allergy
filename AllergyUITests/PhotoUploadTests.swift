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


class PhotoUploadTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false
        try disablePasswordAutofill()

        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "Allergy")

        try app.conductOnboardingIfNeeded()
    }
    
    
    func testPhotoUpload() throws {
        let app = XCUIApplication()
        
        // Baseline
        app.investigateUploadImage(
            task: "Take Baseline Photo",
            image: "Photo, March 12, 2011, 4:17 PM",
            comment: "Testing!",
            testImageName: "base-0"
        )
        
        // Day 0
        app.investigateUploadImage(
            task: "Take Photo After Application",
            image: "Photo, August 08, 2012, 2:29 PM",
            comment: "Testing!",
            testImageName: "day0-0"
        )
        
        // DAY 2
        app.investigateUploadImage(
            task: "Take Photo Two Days After Application",
            image: "Photo, October 09, 2009, 2:09 PM",
            comment: "Testing!",
            testImageName: "day2-0"
        )
        
        // DAY 4
        app.investigateUploadImage(
            task: "Take Photo Two Days After Removal",
            image: "Photo, August 08, 2012, 2:55 PM",
            comment: "Testing!",
            testImageName: "day4-0",
            testScrollDown: true
        )
        
        // Optional
        app.investigateUploadImage(
            task: "Take Optional Photo",
            image: "Photo, August 08, 2012, 2:55 PM",
            comment: "Testing!",
            testImageName: "optional-0",
            testScrollDown: true
        )
    }
}


extension XCUIApplication {
    func investigateUploadImage(task: String, image: String, comment: String, testImageName: String, testScrollDown: Bool = false) {
        tabBars["Tab Bar"].buttons["Schedule"].tap()
        swipeUp(velocity: .slow)
        uploadImage(task: task, image: image, comment: comment)
        
        tabBars["Tab Bar"].buttons["Gallery"].tap()
        if testScrollDown {
            swipeUp(velocity: .slow)
        }
        
        XCTAssert(collectionViews.scrollViews.otherElements.buttons[testImageName].waitForExistence(timeout: 2))
    }
    
    func uploadImage(task: String, image: String, comment: String) {
        let takePhotoStaticText = staticTexts[task]
        XCTAssertTrue(takePhotoStaticText.waitForExistence(timeout: 2))
        takePhotoStaticText.tap()
        
        let addButton = buttons["Add Image"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 2))
        addButton.tap()
        
        // Picks photo
        XCTAssertTrue(buttons["Photo Picker"].waitForExistence(timeout: 2))
        buttons["Photo Picker"].tap()
        
        XCTAssertTrue(images[image].waitForExistence(timeout: 2))
        images[image].tap()
        
        // Enters a comment
        textFields["Enter a comment (optional)"].tap()
        textFields["Enter a comment (optional)"].typeText(comment)
        
        // Upload photo
        buttons["Upload"].tap()
    }
}
