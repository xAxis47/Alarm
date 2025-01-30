//
//  AlarmViewModel.swift
//  Alarm
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
    let aModel: AlarmModel = AlarmModel()
    let bgModel: BackgroundTaskModel = BackgroundTaskModel()
    let dModel: DataModel = DataModel()
    let nModel: NotificationModel = NotificationModel()
    
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

    init() {
        
    }
    
    //this fuction called at MainView.
    func changeToggle() {
        
        self.dModel.saveContext()
        
        let items = self.dModel.fetchItems()
        self.nModel.registerAllNotifications(items: items)
        
    }
    
    func deleteItems(indexSet: IndexSet) {
        
        self.dModel.deleteItems(offsets: indexSet)
        
        let items = self.dModel.fetchItems()
        self.nModel.registerAllNotifications(items: items)
        
    }
    
    func filterTitles(items: [HourAndMinute]) -> [String] {
        
        return Array(Set(items.map({ $0.title })))
            .sorted(by: { $0 < $1 })
            .filter { $0 != Constant.goodMorning }
            .filter { $0 != Constant.blank }
        
    }
    
    func insertSystemName(index: Int) -> String {
        
        let bool = checkMarks[index]
        
        return self.aModel.insertSystemName(bool: bool)
        
    }
    
    func pickUpDaysString() -> String {
        
        return self.aModel.pickUpDaysString(checkMarks: self.checkMarks)
        
    }
    
    func pickUpDaysString(checkMarks: [Bool]) -> String {
        
        return self.aModel.pickUpDaysString(checkMarks: checkMarks)
        
    }
    
    func pickUpHourAndMinuteString(date: Date) -> String {
        
        return self.aModel.pickUpHourAndMinuteString(date: date)
        
    }
    
    //items need?
    func prepareList(items: [HourAndMinute]) -> [String] {
        
        return self.aModel.prepareList(items: items)
        
    }
    
    func registerAllNotifications() {
     
        let items = self.dModel.fetchItems()
        self.nModel.registerAllNotifications(items: items)
        
    }
    
    func saveItemOrCallAlert(dismiss: DismissAction) {
        
        let selectedItem = self.dModel.fetchItem(uuid: indexOfUUID)
        
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
        
        let bool = self.dModel.saveItem(
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
        
        self.bgModel.scheduleAppRefresh()
        
    }
    
    func setTitle(title: String) {
     
        self.title = title
        
    }
    
    //when call this function, setup this ViewModel's variables at new value or edited value.
    func setUpInputView() {
        
        if(self.type == .add) {
            
            print("add")
            
            self.indexOfUUID = UUID()
            
            self.checkMarks = Constant.trueArray
            self.date = Constant.initialDate
            self.title = Constant.initialTitle
            
        } else {
            
            print("edit")
            
            let item = self.dModel.fetchItem(uuid: indexOfUUID)
            
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
