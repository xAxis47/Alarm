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

        let header = "test"
        let textField = app.descendants(matching: .textField).firstMatch
        textField.tap()
        textField.typeText(header)

        let saveButton = app.navigationBars.buttons[Identifier.saveButton]
        saveButton.tap()
        
        let timeString = app.staticTexts["\(Identifier.time)_0"].label
        let weekDayString = app.staticTexts["\(Identifier.dayOfTheWeek)_0"].label
        let headerString = app.staticTexts["\(Identifier.mainSection)_\(header)"].label
          
        XCTAssertTrue(timeString == "12:45", "datePicker is not 12:45")
        XCTAssertTrue(weekDayString == "日,火,木,土", "weekday is not true")
        XCTAssertTrue(headerString == header, "header is not \(header)")

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
        
        let menu = app/*@START_MENU_TOKEN@*/.buttons.otherElements.firstMatch/*[[".otherElements",".element(boundBy: 36)",".containing(.staticText, identifier: \"タイトル\").firstMatch",".buttons.otherElements.firstMatch"],[[[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        menu.tap()
        let menuButton = app.buttons[Identifier.goodMorning]
        menuButton.tap()

        let saveButton = app.navigationBars.buttons[Identifier.saveButton]
        saveButton.tap()
        
        let timeString = app.staticTexts["\(Identifier.time)_0"].label
        let weekDayString = app.staticTexts["\(Identifier.dayOfTheWeek)_0"].label
        let headerString = app.staticTexts["\(Identifier.mainSection)_起床"].label

        XCTAssertTrue(timeString == "11:15", "datePicker is not 11:15")
        XCTAssertTrue(weekDayString == "土", "weekday is not true")
        XCTAssertTrue(headerString == "起床", "header is not \(Identifier.goodMorning)")

    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
