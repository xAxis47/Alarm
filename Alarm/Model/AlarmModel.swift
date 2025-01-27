//
//  AlarmModel.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/12/05.
//
import Foundation
import SwiftData
import SwiftDate
import SwiftUI
import UIKit

@MainActor
class AlarmModel: ObservableObject {

    func insertSystemName(bool: Bool) -> String {
        
        if(bool) {
            
            return "alarm"
            
        } else {
            
            return ""
            
        }
        
    }
    
    //write string of the days of the week or "everyday".
    func pickUpDaysString(checkMarks: [Bool]) -> String {
        
        let trueCount = checkMarks
            .filter { $0 }
        
        if(trueCount.count == 7) {
            
            return Constant.everyday
            
        } else {
            
            let days = checkMarks.enumerated().map { index, bool in
                
                if(bool) {
                    
                    return Constant.dayInitialsArray[index]
                    
                } else {
                    
                    return Constant.blank
                    
                }
                
            }
                .filter { $0 != Constant.blank }
                .joined(separator: Constant.singleComma)
            
            return days
            
        }
        
    }
    
    //write hour and minute of the date. when minutes is 0 ~ 9, is written "00" ~ "09"
    func pickUpHourAndMinuteString(date: Date) -> String {
        
        let region = Region(
            calendar: Calendars.gregorian,
            zone: Zones.current,
            locale: Locales.current
        )
        
        let convertedDate = date.convertTo(region: region)
        
        let hour = convertedDate.hour
        let minute = convertedDate.minute
        
        if(minute >= 0 && minute <= 9) {
            
            return "\(hour):0\(minute)"
            
        } else {
            
            return "\(hour):\(minute)"
            
        }
        
    }
    
    //this "List" is the list on MainView made by items. "header" is assigned sorted list.
    func prepareList(items: [HourAndMinute]) -> [String] {
        
        let titles = Array(Set(items.map({ $0.title })))
            .sorted(by: { $0 < $1 })
        
        let bool = titles.contains(Constant.goodMorning)
        
        let header: [String]
        
        if(bool == true) {
            
            header = titles
                .filter { $0 != Constant.goodMorning }
                .add(Constant.goodMorning)
            
        } else {
            
            header = titles
            
        }
        
        return header
        
    }

}
