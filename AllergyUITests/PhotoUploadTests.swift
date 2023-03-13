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
                var takePhotoStaticText = app.collectionViews.staticTexts["Take Baseline Photo"]
                takePhotoStaticText.tap()
                app.buttons["Add"].tap()
                // Picks photo
                app.collectionViews.buttons["Photo Picker"].tap()
                var testPhoto = "Photo, March 12, 2011, 4:17 PM"
                app.scrollViews.otherElements.images[testPhoto].tap()
        
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                // Upload photo
                app.buttons["Upload"].tap()
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                // Check for existence of photo
                XCTAssertTrue(app.collectionViews.children(matching: .cell).element(boundBy: 1).scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.exists)
                
                // Day 0
                app.tabBars["Tab Bar"].buttons["Schedule"].tap()
                app.swipeUp()
                takePhotoStaticText = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Take Photo After Application"]/*[[".cells.staticTexts[\"Take Photo After Application\"]",".staticTexts[\"Take Photo After Application\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                takePhotoStaticText.tap()
                app.buttons["Add"].tap()
                // Picks photo
                app.collectionViews.buttons["Photo Picker"].tap()
                testPhoto = "Photo, August 08, 2012, 2:29 PM"
                app.scrollViews.otherElements.images[testPhoto].tap()
        
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                // Upload photo
                app.buttons["Upload"].tap()
                
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                // Check for existence of photo
                XCTAssertTrue(app.collectionViews.children(matching: .cell).element(boundBy: 3).scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.exists)
            
                // DAY 2
                
                app.tabBars["Tab Bar"].buttons["Schedule"].tap()
                app.swipeUp()
                takePhotoStaticText = app.collectionViews.staticTexts["Take Photo Two Days After Application"]
                takePhotoStaticText.tap()
                app.buttons["Add"].tap()
                // Picks photo
                app.collectionViews.buttons["Photo Picker"].tap()
                testPhoto = "Photo, October 09, 2009, 2:09 PM"
                app.scrollViews.otherElements.images[testPhoto].tap()
        
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                // Upload photo
                app.buttons["Upload"].tap()
                
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                // Check for existence of photo
                XCTAssertTrue(app.collectionViews.children(matching: .cell).element(boundBy: 5).scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.exists)
                // DAY 4
                
                app.tabBars["Tab Bar"].buttons["Schedule"].tap()
                app.swipeUp()
                takePhotoStaticText = app.collectionViews.staticTexts["Take Photo Two Days After Removal"]
                takePhotoStaticText.tap()
                app.buttons["Add"].tap()
                // Picks photo
                app.collectionViews.buttons["Photo Picker"].tap()
                testPhoto = "Photo, August 08, 2012, 2:55 PM"
                app.scrollViews.otherElements.images[testPhoto].tap()
        
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                // Upload photo
                app.buttons["Upload"].tap()
                
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                // Check for existence of photo
                XCTAssertTrue(app.collectionViews.children(matching: .cell).element(boundBy: 7).scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.exists)
                
                
                // Optional
                
                app.tabBars["Tab Bar"].buttons["Schedule"].tap()
                app.swipeUp()
                takePhotoStaticText = app.collectionViews.staticTexts["Take Optional Photo"]
                takePhotoStaticText.tap()
                app.buttons["Add"].tap()
                // Picks photo
                app.collectionViews.buttons["Photo Picker"].tap()
                testPhoto = "Photo, August 08, 2012, 2:55 PM"
                app.scrollViews.otherElements.images[testPhoto].tap()
        
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                // Upload photo
                app.buttons["Upload"].tap()
                
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                
                                
                
    }
}

