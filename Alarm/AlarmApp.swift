//
//  AlarmApp.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import UIKit
import SwiftUI
import SwiftData
import SwiftDate


@main
@MainActor
struct AlarmApp: App {
    
    let vm: AlarmViewModel = AlarmViewModel()
    
    init() {
        
        let region = Region(calendar: Calendars.gregorian, zone: Zones.asiaTokyo, locale: Locales.japanese)
        SwiftDate.defaultRegion = region
        
        self.vm.registerAllNotifications()
        
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            MainView()
        }
        .environmentObject(self.vm)
        .modelContainer(self.vm.dataModel.sharedModelContainer)
    
        //app refresh and register notification each 3 hours.
        .backgroundTask(.appRefresh(Constant.refreshIdentifier)) {
            
            await withTaskCancellationHandler {
                
                await self.vm.scheduleAppRefresh()
                await self.vm.registerAllNotifications()
                
            } onCancel: {
                
                 print("cancel")
                
            }

        }
        
        
    }
    
}
