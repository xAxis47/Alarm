//
//  AlarmTests.swift
//  AlarmTests
//
//  Created by Kawagoe Wataru on 2025/05/08.
//

import BackgroundTasks
import SwiftData
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
        
        let trueFlag: Flag = Flag(bool: true)
        let falseFlag: Flag = Flag(bool: false)
        
        let everyday = [trueFlag, trueFlag, trueFlag, trueFlag, trueFlag, trueFlag, trueFlag]
        let someDay = [trueFlag, falseFlag, trueFlag, falseFlag, trueFlag, falseFlag, trueFlag]
        
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
        
        let fetchedItems: [HourAndMinute] = dModel.fetchItems()
        
        for i in fetchedItems {
            
            self.dModel.context.delete(i)
            
        }
        
        let item0: HourAndMinute = HourAndMinute(date: Date().addingTimeInterval(0))
        let item1: HourAndMinute = HourAndMinute(date: Date().addingTimeInterval(1))
        let item2: HourAndMinute = HourAndMinute(date: Date().addingTimeInterval(2))
        
        let insertedItems: [HourAndMinute] = [item0, item1, item2]

        for i in insertedItems {
            
            self.dModel.context.insert(i)
            
        }
        try self.dModel.context.save()
        
        let indexSet: IndexSet = [0]
        
        self.dModel.deleteItems(offsets: indexSet)
        
        print("fetched items' count is \(dModel.fetchItems().count)")
      
        XCTAssertTrue(dModel.fetchItems().count == 2, "item is remaining")
        
    }
    
    func testFetchItem() throws {
        
        let fetchedItems: [HourAndMinute] = dModel.fetchItems()
        
        for i in fetchedItems {
            
            self.dModel.context.delete(i)
            
        }
        
        let uuid = UUID()
        
        let insertedItem0: HourAndMinute = HourAndMinute(uuid: uuid)
        let insertedItem1: HourAndMinute = HourAndMinute(uuid: UUID())
        let insertedItem2: HourAndMinute = HourAndMinute(uuid: UUID())
        
        let items: [HourAndMinute] = [insertedItem0, insertedItem1, insertedItem2]
        
        for i in items {
            
            self.dModel.context.insert(i)
            
        }
        try self.dModel.context.save()
        
        let fetchedItem: HourAndMinute = dModel.fetchItem(uuid: uuid)
        
        XCTAssertTrue(fetchedItem.uuid == uuid, "uuid is not equal")
        
    }
    
    func testFetchItems() throws {
        
        let fetchedItems0: [HourAndMinute]
        
        do {
            
            let descriptor = FetchDescriptor<HourAndMinute>(
                sortBy: [SortDescriptor(\.date, order: .forward)]
            )
            
            fetchedItems0 = try dModel.context.fetch(descriptor)
            
        } catch {
            
            fatalError("\(error)")
            
        }
        
        for i in fetchedItems0 {
            
            self.dModel.context.delete(i)
            
        }
        
        let uuid = UUID()
        
        let insertedItem0: HourAndMinute = HourAndMinute(uuid: uuid)
        let insertedItem1: HourAndMinute = HourAndMinute(uuid: UUID())
        let insertedItem2: HourAndMinute = HourAndMinute(uuid: UUID())
        
        let items: [HourAndMinute] = [insertedItem0, insertedItem1, insertedItem2]
        
        for i in items {
            
            self.dModel.context.insert(i)
            
        }
        try self.dModel.context.save()
        
        let descriptor =  FetchDescriptor<HourAndMinute>(
            sortBy: [SortDescriptor(\.date, order: .forward)])
        
        let count = try dModel.context.fetchCount(descriptor)
            
        let fetchedItems1: [HourAndMinute] = dModel.fetchItems()
        
        XCTAssertTrue(fetchedItems1.count == count, "count is different")
        
    }
    
    func testSaveContext() throws {
        
        let fetchedItems: [HourAndMinute] = self.dModel.fetchItems()
        
        for i in fetchedItems {
            
            self.dModel.context.delete(i)
            
        }
        
        let item: HourAndMinute = HourAndMinute()
        self.dModel.context.insert(item)
        dModel.saveContext()
        
        let fetchedItem: [HourAndMinute] = dModel.fetchItems()
        
        XCTAssertTrue(fetchedItem.count == 1, "item's count is not 1")
        
    }
    
    func testSaveItem() throws {
        
        let fetchedItems: [HourAndMinute] = self.dModel.fetchItems()
        
        for i in fetchedItems {
            
            self.dModel.context.delete(i)
            
        }
        
        let date = Date()
        
        let uuid0 = UUID()
        let insertedItem: HourAndMinute = HourAndMinute(uuid: uuid0)
        self.dModel.context.insert(insertedItem)
        dModel.saveContext()
        
        let uuid1 = UUID()
        let blankTitleNewItem: HourAndMinute = HourAndMinute(date: date, uuid: uuid1)
        let _ = dModel.saveItem(indexUUID: uuid0, item: blankTitleNewItem, type: .add)
        
        XCTAssertTrue(dModel.testNumber == 0, "don't insert blankTitleNewItem()")
        
        let otherTitleNewItem: HourAndMinute = HourAndMinute(date: Date(), title: "title")
        let _ = dModel.saveItem(indexUUID: uuid0, item: otherTitleNewItem, type: .add)
        
        XCTAssertTrue(dModel.testNumber == 1, "don't insert otherTitleNewItem()")
        
        let conflictAlert: HourAndMinute = HourAndMinute(date: date, title: Constant.blank)
        let _ = dModel.saveItem(indexUUID: uuid0, item: conflictAlert, type: .add)
        
        XCTAssertTrue(dModel.testNumber == 2, "don't insert conflictAlert()")
        
        let noChangeEditItem: HourAndMinute = HourAndMinute(checkMarks: Constant.trueArray, date: Constant.initialDate, title: Constant.blank)
        let _ = dModel.saveItem(indexUUID: uuid0, item: noChangeEditItem, type: .edit)
        
        XCTAssertTrue(dModel.testNumber == 3, "don't insert noChangeEditItem()")
        
        let blankEditItem: HourAndMinute = HourAndMinute(date: Date(), title: Constant.blank)
        let _ = dModel.saveItem(indexUUID: uuid0, item: blankEditItem, type: .edit)
        
        XCTAssertTrue(dModel.testNumber == 4, "don't insert blankEditItem()")
        
        let editTitleItem: HourAndMinute = HourAndMinute(date: Date(), title: "other")
        let _ = dModel.saveItem(indexUUID: uuid0, item: editTitleItem, type: .edit)
        
        XCTAssertTrue(dModel.testNumber == 5, "don't insert editTitleItem()")
        
        let editCheckmarkAndTitleItem: HourAndMinute = HourAndMinute(date: date, uuid: uuid0)
        let _ = dModel.saveItem(indexUUID: uuid1, item: editCheckmarkAndTitleItem, type: .edit)
        
        XCTAssertTrue(dModel.testNumber == 6, "don't insert editCheckmarkAndTitleItem()")
    }
    
    let nModel: NotificationModel = NotificationModel()
    
    func testCheckDailyCondition() {
        
        let trueArray: [Flag] = Constant.trueArray
        let falseArray: [Flag] = Constant.falseArray
        
        XCTAssertTrue(nModel.checkDailyCondition(checkMarks: trueArray, isToday: true))
        XCTAssertFalse(nModel.checkDailyCondition(checkMarks: falseArray, isToday: true))

    }
    
    func testGetDateDifference() {
        
        let itemDate = DateInRegion(seconds: 10 * 60 * 60).date
        let item = HourAndMinute(date: itemDate)
        
        let date = DateInRegion(seconds: 11 * 60 * 60).date
        
        let difference = nModel.getDateDifference(count: 0, currentDate: date, item: item)
        
        let interval = (itemDate - date).timeInterval
        
        XCTAssertTrue(difference == interval, "difference is not correct")
        
    }
    
}
