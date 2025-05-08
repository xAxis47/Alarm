//
//  SceneDelegate.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/05/11.
//

//import UIKit
//import CoreData
//import BackgroundTasks
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    let vm: AlarmViewModel = AlarmViewModel()
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constant.refreshIdentifier, using: nil) { task in
//            
//            self.vm.registerAllNotifications()
//            self.vm.scheduleAppRefresh()
//            
//            task.setTaskCompleted(success: true)
//            
//        }
//
//        BGTaskScheduler.shared.getPendingTaskRequests { requests in
//            print("requests is \(requests)")
//        }
//
//        return true
//    }
//
//}
