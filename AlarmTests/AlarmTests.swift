//
//  AlarmTests.swift
//  AlarmTests
//
//  Created by Kawagoe Wataru on 2025/05/08.
//

import BackgroundTasks
import SwiftDate
import XCTest
@testable import Alarm

@MainActor
final class AlarmTests: XCTestCase {
    
    let aModel: AlarmModel = AlarmModel()
    
    let items: [HourAndMinute] = (0...3)
        .map { i in HourAndMinute(title: "\(i)") }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFilterHeader() throws {
        
        let title = aModel.filterHeader(items: items)
        
        XCTAssertTrue(title == "0", "return value is not 0")
        
    }
    
    func testFilterTitles() throws {
        
        let titleArray = aModel.filterTitles(items: items)
        
        XCTAssertTrue(titleArray == ["0", "1", "2", "3"], "return value of filterTitles is not String Array: [0, 1, 2, 3] ")
        
    }
    
    func testInsertSystemName() throws {
        
        let trueValue = aModel.insertSystemName(bool: true)
        let falseValue = aModel.insertSystemName(bool: false)
        
        XCTAssertTrue(trueValue == "alarm", "return value of insertSystemName is not alarm")
        XCTAssertTrue(falseValue == "", "return value of insertSystemName is not blank")
        
    }
    
    func testPickUpDayOfTheWeek() throws {
        
        let everyday = [true, true, true, true, true, true, true]
        let someDay = [true, false, true, false, true, false, true]
        
        let everydayString = aModel.pickUpDayOfTheWeek(checkMarks: everyday)
        let someDayString = aModel.pickUpDayOfTheWeek(checkMarks: someDay)
        
        XCTAssertTrue(everydayString == Constant.everyday, "return value of pickUpDayOfTheWeek is not 毎日")
        XCTAssertTrue(someDayString == "日,火,木,土", "return value of pickUpDayOfTheWeek is not 日,火,木,土")
        
    }
    
    func testPickUpTime() throws {
        
        let tenHour = Date(year: 2025, month: 5, day: 7, hour: 10, minute: 0)
        let nineHourThirtyMinutes = Date(year: 2025, month: 5, day: 7, hour: 9, minute: 30)
        
        let tenHourString = aModel.pickUpTime(date: tenHour)
        let nineHourThirtyMinutesString = aModel.pickUpTime(date: nineHourThirtyMinutes)
        
        XCTAssertTrue(tenHourString == "10:00", "return value of pickUpTime is not 10:00")
        XCTAssertTrue(nineHourThirtyMinutesString == "9:30", "return value of pickuUpTime is not 9:30")
        
    }
    
    func testPrepareItems() throws {
        
        let leftSideDoubleArray: [[String]] = aModel
            .prepareItems(items: items)
            .map { [$0.first!.title] }
        let rightSideDoubleArray: [[String]] = [["0"], ["1"], ["2"], ["3"]]
        
        XCTAssertTrue(leftSideDoubleArray == rightSideDoubleArray, "return value of prepareItems is not items' double array")
        
    }
    
    let bModel: BackgroundTaskModel = BackgroundTaskModel()
    
    func testRegisterBackgroundTask() throws {
        
        bModel.scheduleAppRefresh()
        
    }
    
    let dModel: DataModel = DataModel()
    
    func testDeleteItems() throws {
        
        let items = dModel.fetchItems()
        
        print("items: \(items.count)")
        
        let array: [Int] = items.enumerated().map {  $0.offset }
        let indexSet: IndexSet = IndexSet(array)

        dModel.deleteItems(offsets: indexSet)
      
        XCTAssert(dModel.fetchItems().count == 0, "item is remaining")
        
    }
    
}
