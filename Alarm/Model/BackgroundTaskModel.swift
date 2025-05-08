//
//  BackgroundTaskModel.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/30.
//
import BackgroundTasks

class BackgroundTaskModel {
    
    func scheduleAppRefresh() {
        
        let today = Date()
        let nextDate = Date(year: today.year, month: today.month, day: today.day, hour: 23, minute: 50)

        let request = BGAppRefreshTaskRequest(identifier: Constant.refreshIdentifier)
        request.earliestBeginDate = nextDate

        do {
            
            try BGTaskScheduler.shared.submit(request)
            
        } catch {
            
            print("scheduleAppRefresh")
            
            print("error")
            
        }
        
    }
    
    //this schedule is background task schedule. in this app, use AppRefresh. this time every 3 hours.
//    func scheduleAppRefresh() {
//        
//        let today = Date()
//        let interval = DateComponents(hour: 3)
//        let next = Calendar.current.date(byAdding: interval, to: today)
//
//        let request = BGAppRefreshTaskRequest(identifier: Constant.refreshIdentifier)
//        request.earliestBeginDate = next!
//
//        do {
//            
//            try BGTaskScheduler.shared.submit(request)
//            
//            print("submit")
//            
//        } catch {
//            
//            print("scheduleAppRefresh")
//            
//            print("error")
//            
//        }
//        
//    }
    
}
