//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTestExtensions


class GalleryViewTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--skipOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "Allergy")
    }
    
    
    // swiftlint:disable:next function_body_length
    func testGalleryView() throws {
                let app = XCUIApplication()
                XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Gallery"].waitForExistence(timeout: 2))
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                XCTAssertTrue(app.staticTexts["day0"].waitForExistence(timeout: 2))
                XCTAssertTrue(app.staticTexts["day2"].waitForExistence(timeout: 2))
                XCTAssertTrue(app.staticTexts["day4"].waitForExistence(timeout: 2))
                XCTAssertTrue(app.staticTexts["base"].waitForExistence(timeout: 2))
                app.swipeUp()
                XCTAssertTrue(app.staticTexts["optional"].waitForExistence(timeout: 2))
    }
    
    
    func testPhotoUpload() throws {
                let app = XCUIApplication()
                XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Gallery"].waitForExistence(timeout: 2))
                app.tabBars["Tab Bar"].buttons["Gallery"].tap()
                


        
        

    }
    
}