//
//  GalleryViewTests.swift
//  AllergyUITests
//
//  Created by Rachel Wu on 3/6/23.
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
    }
}
