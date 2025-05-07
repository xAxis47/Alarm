//
//  AlarmViewModel.swift
//  Alarms
//
//  Created by Kawagoe Wataru on 2024/12/05.
//

import AVFoundation
import BackgroundTasks
import Foundation
import Observation
import SwiftData
import SwiftDate
import SwiftUI
import UserNotifications

@MainActor
@Observable
final class AlarmViewModel: ObservableObject {
    
    //singleton
    static let shared: AlarmViewModel = AlarmViewModel()
    
    //model
    let alarmModel: AlarmModel = AlarmModel()
    let backgroundTaskModel: BackgroundTaskModel = BackgroundTaskModel()
    let dataModel: DataModel = DataModel()
    let notificationModel: NotificationModel = NotificationModel()
    
    //view property
    var checkMarks: [Bool] = Constant.trueArray
    var date: Date = Constant.initialDate
    var title: String = ""
    
    var indexOfUUID: UUID = UUID()
    
    var conflictAlertIsPresented: Bool = false
    var limitAlertIsPresented: Bool = false
    var sheetIsPresented: Bool = false
    var zeroTrueAlertIsPresented: Bool = false
    
    //enum
    var type: EditorialType = .add

    //this fuction called at MainView.
    func changeToggle() {
        
        self.dataModel.saveContext()
        
        let items = self.dataModel.fetchItems()
        self.notificationModel.registerAllNotifications(items: items)
        
    }
    
    func deleteItems(indexSet: IndexSet) {
        
        self.dataModel.deleteItems(offsets: indexSet)
        
        let items = self.dataModel.fetchItems()
        self.notificationModel.registerAllNotifications(items: items)
        
    }
    
    func filterHeader(items: [HourAndMinute]) -> String {
        return self.alarmModel.filterHeader(
            titles: self.alarmModel.getTitles(_:),
            items: items
        )
    }
    
    func filterTitles(items: [HourAndMinute]) -> [String] {
        return self.alarmModel.filterTitles(
            titles: self.alarmModel.getTitles(_:),
            items: items
        )
    }
    
    func insertSystemName(index: Int) -> String {
    
        let bool = checkMarks[index]
        
        return self.alarmModel.insertSystemName(bool: bool)
        
    }
    
    func pickUpDayOfTheWeek() -> String {
        return self.alarmModel.pickUpDayOfTheWeek(checkMarks: self.checkMarks)
    }
    
    func pickUpDayOfTheWeek(checkMarks: [Bool]) -> String {
        return self.alarmModel.pickUpDayOfTheWeek(checkMarks: checkMarks)
    }
    
    func pickUpTime(date: Date) -> String {
        return self.alarmModel.pickUpTime(date: date)
    }
    
    func prepareItems(items: [HourAndMinute]) -> [[HourAndMinute]] {
        return self.alarmModel.prepareItems(
            titles: self.alarmModel.getTitles(_:),
            items: items
        )
    }
    
    func registerAllNotifications() {
     
        let items = self.dataModel.fetchItems()
        self.notificationModel.registerAllNotifications(items: items)
        
    }
    
    func saveItemOrCallAlert(dismiss: DismissAction) {
        
        let selectedItem = self.dataModel.fetchItem(uuid: indexOfUUID)
        
        let saveItem: HourAndMinute
        
        switch self.type {
            
        case .add:
            
            saveItem = HourAndMinute(
                checkMarks: self.checkMarks,
                date: self.date,
                title: self.title
            )
            
        case .edit:
            
            saveItem = HourAndMinute(
                checkMarks: self.checkMarks,
                date: self.date,
                isOn: selectedItem.isOn,
                title: self.title,
                uuid: selectedItem.uuid
            )
            
        }
        
        let bool = self.dataModel.saveItem(
            indexUUID: self.indexOfUUID,
            item: saveItem,
            type: self.type
        )
        
        if let isAlert = bool {
            
            conflictAlertIsPresented = isAlert
            
        } else {
            
            dismiss()
            
        }
        
    }
    
    func scheduleAppRefresh() {
        
        self.backgroundTaskModel.scheduleAppRefresh()
        
    }
    
    func setTitle(title: String) {
     
        self.title = title
        
    }
    
    //when call this function, setup this ViewModel's variables at new value or edited value.
    func setUpInputView() {
        
        if(self.type == .add) {
            
            self.indexOfUUID = UUID()
            
            self.checkMarks = Constant.trueArray
            self.date = Constant.initialDate
            self.title = Constant.initialTitle
            
        } else {
            
            let item = self.dataModel.fetchItem(uuid: indexOfUUID)
            
            self.checkMarks = item.checkMarks
            self.date = item.date
            self.title = item.title
            
        }
        
    }
    
    func tapAlarmCell(uuid: UUID) {
        
        //index is for setting InputView.
        self.indexOfUUID = uuid
        
        self.type = .edit
        self.setUpInputView()
        self.sheetIsPresented = true
        
    }
    
    func tapMarkCell(index: Int) {
        
        //decide ringing sound or not here.
        self.checkMarks[index].toggle()
        
        let trueCount = self.checkMarks.filter { $0 }
            .count
        
        //this alert is called when there are no icons.
        if (trueCount == 0) {
            
            self.zeroTrueAlertIsPresented = true
            
            //the number of icons cant remain at 0, so display the icons again here.
            self.checkMarks[index].toggle()
            
        }
        
    }
    
    func tapMenuButton() {
        
        self.title = title
        
    }
    
    //when alarm is over 16 items, alert is called and stop adding alarm. otherwise can transition to InputView.
    func tapPlusButton(items: [HourAndMinute]) {
        
        if(items.count > 16) {
            
            self.limitAlertIsPresented = true
            
        } else {
            
            self.type = .add
            self.setUpInputView()
            self.sheetIsPresented = true
            
        }
        
    }
    
}
