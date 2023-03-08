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
                //let app2 = app
                //let app = app2
                // tap schedule tab
                // tap take photo button for task #1
                
                
                
                app.buttons["Add"].tap()
                
                // Picks photo
                app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Photo Picker"]/*[[".cells.buttons[\"Photo Picker\"]",".buttons[\"Photo Picker\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, March 12, 2011, 4:17 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 30, 2018, 12:14 PM, Photo, August 08, 2012, 2:55 PM, Photo, August 08, 2012, 2:29 PM, Photo, August 08, 2012, 11:52 AM, Photo, October 09, 2009, 2:09 PM, Photo, March 12, 2011, 4:17 PM\"].images[\"Photo, March 12, 2011, 4:17 PM\"]",".images[\"Photo, March 12, 2011, 4:17 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
                
                // Enters a comment
                app.textFields["Enter a comment (optional)"].tap()
                app.textFields["Enter a comment (optional)"].typeText("Testing!")
                
                // Upload photo
                app.buttons["Upload"].tap()
                
                // Switch to gallery tab to check for existence of photo and text
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                
                // Check for existence of text
                XCTAssertTrue(app.staticTexts["Testing!"].waitForExistence(timeout: 2))
                
                // Check for existence of photo
                // Currently just taps the day0 box
                XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 3).scrollViews.containing(.other, identifier:"Horizontal scroll bar, 1 page").element.tap()

                
    }
}

