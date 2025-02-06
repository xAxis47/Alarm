//
//  AlarmTests.swift
//  AlarmTests
//
//  Created by Kawagoe Wataru on 2025/01/25.
//

import XCTest

@MainActor
final class AlarmTests: XCTestCase {
    
    let model: AlarmModel = AlarmModel()
    
    func testFilterHeader() {
        
        let title = "起床"
        
        let item1 = HourAndMinute(checkMarks: Constant.trueArray, date: Date(), title: title)
        let item2 = HourAndMinute(checkMarks: Constant.trueArray, date: Date(), title: title)
        
        XCTAssertEqual(model.filterHeader(items: [item1, item2]), title)
        
    }
    
    func testInsertSystemName() {
        
        XCTAssertEqual(model.insertSystemName(bool: true), "alarm")
        
    }
    
    func testPickUpDayOfTheWeek() {
        
        XCTAssertEqual(model.pickUpDayOfTheWeek(checkMarks: [true, true, true, false, true, true, true]), "日,月,火,木,金,土")
        
    }
    
    func testPickUpTime() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = .autoupdatingCurrent
        
        let dateString = "10:00"

        let date = formatter.date(from: dateString)!
        
        XCTAssertEqual(model.pickUpTime(date: date), "10:00")

    }
    
    func testPrepareItems() {
        
        let title1 = "起床"
        let title2 = "昼食"
        
        let item1 = HourAndMinute(checkMarks: Constant.trueArray, date: Date(), title: title1)
        let item2 = HourAndMinute(checkMarks: Constant.trueArray, date: Date(), title: title2)
        let item3 = HourAndMinute(checkMarks: Constant.trueArray, date: Date(), title: title2)
        
        XCTAssertEqual(model.prepareItems(items: [item1, item2, item3]), [[item1], [item2, item3]])
        
    }

}
