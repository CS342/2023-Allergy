//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTestExtensions


class SchedulerAndQuestionnaireTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--skipOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "Allergy")
    }
    
    
    // swiftlint:disable:next function_body_length
    func testSchedulerAndQuestionnaire() throws {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Schedule"].waitForExistence(timeout: 2))
        app.tabBars["Tab Bar"].buttons["Schedule"].tap()
        
        XCTAssertTrue(app.staticTexts["Start Questionnaire"].waitForExistence(timeout: 2))
        app.staticTexts["Start Questionnaire"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Myself"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["Myself"].tap()
        app.tables.staticTexts["My child"].tap()
        app.tables.staticTexts["Another person"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Male"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["Male"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.textFields["Tap to answer"].waitForExistence(timeout: 0.5))
        app.textFields["Tap to answer"].tap()
        app.textFields["Tap to answer"].typeText("1990")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        XCTAssertTrue(app.buttons["Next"].waitForExistence(timeout: 0.5))
        app.buttons["Next"].tap()
          
        XCTAssertTrue(app.tables.staticTexts["White"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["White"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.textFields["Tap to answer"].waitForExistence(timeout: 0.5))
        app.textFields["Tap to answer"].tap()
        app.textFields["Tap to answer"].typeText("94305")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        XCTAssertTrue(app.buttons["Next"].waitForExistence(timeout: 0.5))
        app.buttons["Next"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["I am able to manage it but interested to learn more"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["I am able to manage it but interested to learn more"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Sensitive skin in general"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["Sensitive skin in general"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["None of the above"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["None of the above"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Yes"].waitForExistence(timeout: 0.5))
        app.tables.staticTexts["Yes"].tap()
        XCTAssertTrue(app.tables.buttons["Next"].waitForExistence(timeout: 0.5))
        app.tables.buttons["Next"].tap()
        
        XCTAssertTrue(app.textFields["Tap to answer"].waitForExistence(timeout: 0.5))
        app.textFields["Tap to answer"].tap()
        app.textFields["Tap to answer"].typeText("dihydrogen monoxide")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        XCTAssertTrue(app.buttons["Next"].waitForExistence(timeout: 0.5))
        app.buttons["Next"].tap()
        
        XCTAssertTrue(app.textFields["Tap to answer"].waitForExistence(timeout: 0.5))
        app.textFields["Tap to answer"].tap()
        app.textFields["Tap to answer"].typeText("doctor")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        XCTAssertTrue(app.buttons["Done"].waitForExistence(timeout: 0.5))
        app.buttons["Done"].tap()
        
        XCTAssertTrue(!app.staticTexts["Start Questionnaire"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.images["Selected"].waitForExistence(timeout: 2))
    }
}
