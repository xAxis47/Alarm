//
//  AlarmUITests.swift
//  AlarmUITests
//
//  Created by Kawagoe Wataru on 2025/05/08.
//

import XCTest
@testable import Alarm

final class AlarmUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchElement() throws {
        
        let addButton = app.navigationBars.buttons[Identifier.plusButton]
        addButton.tap()

//        for cell in cells.allElementsBoundByAccessibilityElement {
//            
//            print(cell.identifier)
//            
//        }
        
    }
    
    @MainActor
    func testTapAddButton() throws {
        
        let addButton = app.navigationBars.buttons[Identifier.plusButton]
        addButton.tap()

        let datePicker = app.descendants(matching: .datePicker).firstMatch
        
        datePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "12")
        datePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "45")
        
        let settingCell = app.collectionViews[Identifier.inputList].cells.element(boundBy: 1)
        settingCell.tap()
        
        let markCells = app.collectionViews[Identifier.markView].descendants(matching: .cell)

        let munday = markCells.element(boundBy: 1)
        let wednesday = markCells.element(boundBy: 3)
        let friday = markCells.element(boundBy: 5)
        
        munday.tap()
        wednesday.tap()
        friday.tap()
        
        let backButton = app.navigationBars.buttons[Identifier.markBackward]
        backButton.tap()
        
        let saveButton = app.navigationBars.buttons[Identifier.saveButton]
        saveButton.tap()
        
        let timeString = app.staticTexts["\(Identifier.time)_0"].label
        let weekDayString = app.staticTexts["\(Identifier.dayOfTheWeek)_0"].label
        
        XCTAssertTrue(timeString == "12:45", "datePicker is not 12:45")
        XCTAssertTrue(weekDayString == "日,火,木,土", "weekday is not true")

    }
    
    @MainActor
    func testChangeAddedCell() throws {
        
        try testTapAddButton()
        
        let mainCell = app.collectionViews[Identifier.mainList].cells.element(boundBy: 1)
        mainCell.tap()
        
        let datePicker = app.descendants(matching: .datePicker).firstMatch
        
        datePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "15")
        
        let settingCell = app.collectionViews[Identifier.inputList].cells.element(boundBy: 1)
        settingCell.tap()
        
        let markCells = app.collectionViews[Identifier.markView].descendants(matching: .cell)
        
        let sunday = markCells.element(boundBy: 0)
        let thursday = markCells.element(boundBy: 2)
        let wednesday = markCells.element(boundBy: 4)
        
        sunday.tap()
        thursday.tap()
        wednesday.tap()
        
        let backButton = app.navigationBars.buttons[Identifier.markBackward]
        backButton.tap()
//        
//        let header = "test"
//        let textField = app.descendants(matching: .textField).firstMatch
//        textField.typeText(header)

        let saveButton = app.navigationBars.buttons[Identifier.saveButton]
        saveButton.tap()
        
        let timeString = app.staticTexts["\(Identifier.time)_0"].label
        let weekDayString = app.staticTexts["\(Identifier.dayOfTheWeek)_0"].label
//        let headerString = app.staticTexts["\(Identifier.mainHeader)_\(header)"].label
        
        XCTAssertTrue(timeString == "11:15", "datePicker is not 11:15")
        XCTAssertTrue(weekDayString == "土", "weekday is not true")
//        XCTAssertTrue(headerString == header, "header is not \(header)")

    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
