//
//  AppDelegate.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/09/29.
//

import BackgroundTasks
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let shared: AlarmViewModel = AlarmViewModel.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        shared.scheduleAppRefresh()
        shared.registerAllNotifications()
        
        return true
        
    }
    
}
