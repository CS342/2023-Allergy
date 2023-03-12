//
//  GalleryViewTests.swift
//  AllergyUITests
//
//  Created by Rachel Wu on 3/6/23.
//

import XCTest
import XCTestExtensions
import XCTHealthKit



class PhotoUploadTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--skipOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "Allergy")
    }
    
    
    // swiftlint:disable:next function_body_length
            func testPhotoUpload() throws {
                
                let app = XCUIApplication()
                let takePhotoStaticText = app.collectionViews.children(matching: .cell).element(boundBy: 2).staticTexts["Take Photo"]
                takePhotoStaticText.tap()
                app.buttons["Add"].tap()
                // Picks photo
                app.collectionViews.buttons["Photo Picker"].tap()
                let testPhoto = "Photo, March 12, 2011, 4:17 PM"
                app.scrollViews.otherElements.images[testPhoto].tap()
        
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                // Upload photo
                app.buttons["Upload"].tap()
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                // Check for existence of photo
                app.images[testPhoto].exists
                
    }
}

