//
//  NotificationModel.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/30.
//

import UserNotifications
import SwiftDate

final class NotificationModel {
    
    let center: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    //notificationDelegate is from UNUserNotificationCenterDelegate. userNotifcation include "willPresentnotification" and "didReceiveresponse". "willPresentnotification" is set [.list, .banner, .badge, .sound].
    let notificationDelegate = ForegroundNotificationDelegate()
    
    init() {
        
        //this is request permission. if permitted, notificationDelegate assign self.center.delegate.
        self.center.requestAuthorization(
            options: [.alert, .badge, .sound],
            completionHandler: { (granted, _) in
                
                if(granted) {
                    
                    self.center.delegate = self.notificationDelegate
                    
                }
                
            }
            
        )
        
    }
    
    //2 notification are added. first is ringing notification and second notification is silence. after request notification, identifier add suffix and count. timeInterval need over 0.
    func addNotification(condition: Bool, count: Int, currentDate: Date, item: HourAndMinute) {
        
        if(condition) {
            
            let timeInterval = getDateDifference(
                count: count,
                currentDate: currentDate,
                item: item
            )
            
            let identifier = String(describing: item.uuid)
            
            requestNotification(
                body: Constant.timeHasCome,
                identifier: identifier,
                soundName: Constant.testSound,
                suffix: Constant.suffix00,
                count: count,
                timeInterval: timeInterval,
                title: item.title
            )
            
        }
        
    }
    
    //"checkMarks[index]" is express on or off of the days of the week. if not isToday is next day. index is assigned from temporary.
    func checkDailyCondition(checkMarks: [Bool], isToday: Bool) -> Bool {
        
        //weekday return 1 ~ 7. 1 is Sunday and 7 is Saturday.
        let weekday = Date().weekday
        
        let temporary: Int
        
        //day minus 1 from "weekday" because subscript is 0 ~ 6.
        if(isToday) {
            
            //if isToday, don't add anything.
            temporary = weekday - 1
            
        } else {
            
            //if not isToday, qeual next day, add 1.
            temporary = weekday - 1 + 1
            
        }
        
        let index: Int
        
        //when "temporary" is over 7, need to minus 7 to 0 ~ 6.
        if(temporary >= 7) {
            
            index = temporary - 7
            
        } else {
            
            index = temporary
            
        }
        
        //call specific days of the week
        return checkMarks[index]
        
    }
    
    //delete specific notification from UUID.
    func deleteNotification(item: HourAndMinute) {
        
        let identifier = String(describing: item.uuid)
        
        self.center.removePendingNotificationRequests(withIdentifiers: [identifier])
        
    }
    
    //get the difference between today's or tomorrow's date and the item's date. item's date is 1970/01/01.
    func getDateDifference(count: Int, currentDate: Date, item: HourAndMinute) -> TimeInterval {
        
        let targetDate = DateInRegion(
            components: {
                $0.year = currentDate.year
                $0.month = currentDate.month
                $0.day = currentDate.day + count        //here is adding count
                $0.hour = item.date.hour                //change only hours
                $0.minute = item.date.minute            // and minutes
                $0.second = 0
                $0.nanosecond = 0
            }
        )!.date
        
        let timeInterval = (targetDate - currentDate).timeInterval
        
        return timeInterval
        
    }
    
    //request include string at content, trigger at time interval, and identifier.
    func requestNotification(body: String, identifier: String, soundName: String, suffix: String, count: Int, timeInterval: TimeInterval, title: String) {
        
        if(timeInterval > 0) {
            
            let sound = UNNotificationSound(
                named: UNNotificationSoundName(soundName)
            )
            
            let content = UNMutableNotificationContent()
            
            content.title = title
            content.body = body
            content.sound = sound
            
            let id = identifier + suffix + String(describing: count)
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: timeInterval,
                repeats: false
            )
            let request = UNNotificationRequest(
                identifier: id,
                content: content,
                trigger: trigger
            )
            
            self.center.add(request)
            
        }
        
    }
    
    //this function is most important of this App. at first remove registered notification, bring and assign items to itemsToday or itemsNextDay. after that check conditions(isOn and through checkMarks), carry out function.
    func registerAllNotifications(items: [HourAndMinute]) {
        
        self.center.removeAllPendingNotificationRequests()
        self.center.removeAllDeliveredNotifications()
        
        let currentDate = Date()
        
//        let items = self.fetchItems()
        
        items.forEach { item in
            
            if(item.isOn) {
                
                let condition = self.checkDailyCondition(
                    checkMarks: item.checkMarks,
                    isToday: true
                )
                
                self.addNotification(
                    condition: condition,
                    count: Constant.today,
                    currentDate: currentDate,
                    item: item
                )
                
            }
            
        }
        
        items.forEach { item in
            
            if(item.isOn) {
                
                let condition = self.checkDailyCondition(
                    checkMarks: item.checkMarks,
                    isToday: false
                )
                
                self.addNotification(
                    condition: condition,
                    count: Constant.nextDay,
                    currentDate: currentDate,
                    item: item
                )
                
            }
            
        }
        
    }
    
}
