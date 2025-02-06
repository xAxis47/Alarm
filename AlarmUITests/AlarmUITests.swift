//
//  AlarmUITests.swift
//  AlarmUITests
//
//  Created by Kawagoe Wataru on 2025/01/25.
//

import XCTest
@testable import Alarm

final class AlarmUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInsertData() {
        
        let hour = "10"
        let minute = "00"
        let header = "text"
        
        let app = XCUIApplication()
        
        app.launch()
        
        let plusButton = app.buttons[Identifier.main.plusButton]
                
        plusButton.tap()
        
        let pickerWheel = app.descendants(matching: .datePicker).firstMatch.pickerWheels
        
        pickerWheel.element(boundBy: 0).adjust(toPickerWheelValue: hour)
        pickerWheel.element(boundBy: 1).adjust(toPickerWheelValue: minute)
        
        let markNavigationLink = app.otherElements.buttons[Identifier.input.settingSection].firstMatch
        
        markNavigationLink.tap()
        
        let markCell = app.buttons["\(Identifier.mark.button)_\(0)"]
        
        markCell.tap()
        
        let backButton = app.navigationBars.buttons.element(boundBy: 2)
        
        backButton.tap()
        
        let textfield = app.descendants(matching: .textField).firstMatch
        
        textfield.tap()
        
        textfield.typeText(header)
        
        let saveButton = app.buttons[Identifier.input.saveButton]
        
        saveButton.tap()
        
        let time = app.descendants(matching: .staticText).matching(identifier: "\(Identifier.main.time)_\(0)").element.label
        let dayOfTheWeek = app.descendants(matching: .staticText).matching(identifier: "\(Identifier.main.dayOfTheWeek)_\(0)").element.label
        let title = app.descendants(matching: .staticText).matching(identifier: "\(Identifier.main.mainSection)").element.label
        
        XCTAssertEqual(time, "\(hour):\(minute)", "時間が正しい")
        XCTAssertEqual(dayOfTheWeek, "月,火,水,木,金,土", "曜日が正しい")
        XCTAssertEqual(title, header, "セクションのheaderが正しい")
        
    }
    
}
