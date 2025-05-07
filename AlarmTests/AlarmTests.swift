//
//  AlarmTests.swift
//  AlarmTests
//
//  Created by Kawagoe Wataru on 2025/05/07.
//

import XCTest
@testable import Alarm

@MainActor
final class AlarmTests: XCTestCase {
    
    let aModel: AlarmModel = AlarmModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterHeader() throws {
        
        let items: [HourAndMinute] = (0...3).map { i in HourAndMinute(title: "\(i)")}
        
        let string = aModel.filterHeader(items: items)
       
        items.forEach {
            print($0.title)
        }
        print(string)
        
        XCTAssertTrue(string == "0", "filterHeader function return wrong value")
        
    }

}
