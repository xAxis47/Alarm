//
//  AlarmApp.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import SwiftUI
import SwiftData


@main
@MainActor
struct AlarmApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//    let shared: AlarmViewModel = AlarmViewModel.shared
    let vm: AlarmViewModel = AlarmViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            
            MainView()
                .environmentObject(self.vm)
                .modelContainer(self.vm.dataModel.sharedModelContainer)
            
        }
        //app refresh and register notification each 3 hours.
        .backgroundTask(.appRefresh(Constant.refreshIdentifier)){
            
            await self.vm.scheduleAppRefresh()
            await self.vm.registerAllNotifications()
            
        }
        
        
    }
    
}
