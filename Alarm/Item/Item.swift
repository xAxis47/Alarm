//
//  Item.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import Foundation
import SwiftData

struct Flag: Codable, Equatable {
    
    var bool: Bool
    
}

@Model
final class HourAndMinute: Hashable {
    
    var checkMarks: [Flag] = Constant.trueArray
    @Attribute(.unique) var date: Date = Constant.initialDate
    var isOn: Bool = true
    var title: String = Constant.goodMorning
    @Attribute(.unique) var uuid: UUID = UUID()
    
    init() {
        
        self.checkMarks = Constant.trueArray
        self.date = Constant.initialDate
        self.isOn = true
        self.title = Constant.blank
        self.uuid = UUID()
        
    }
    
    init(title: String) {
        
        self.checkMarks = Constant.trueArray
        self.date = Constant.initialDate
        self.isOn = true
        self.title = title
        self.uuid = UUID()
        
    }
    
    init(checkMarks: [Flag], date: Date, title: String) {
        
        self.checkMarks = checkMarks
        self.date = date
        self.isOn = true
        self.title = title
        self.uuid = UUID()
        
    }
    
    init(checkMarks: [Flag], date: Date, isOn: Bool, title: String, uuid: UUID) {
        
        self.checkMarks = checkMarks
        self.date = date
        self.isOn = isOn
        self.title = title
        self.uuid = uuid
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}
