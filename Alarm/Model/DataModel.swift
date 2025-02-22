//
//  Data.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/30.
//
import SwiftData
import SwiftUI

@MainActor
class DataModel {
    
    let sharedModelContainer: ModelContainer
    
    let context: ModelContext
    
    init() {
        
        let schema = Schema([
            HourAndMinute.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
        } catch {
            
            fatalError("\(error)")
            
        }
        
        self.context = self.sharedModelContainer.mainContext

    }
    
    //delete the item, with the amount equal to "offsets". this function is called at MainSection in MainView.
    func deleteItems(offsets: IndexSet) {
        
        let items = fetchItems()
        
        withAnimation {
            
            for index in offsets {
               
                self.context.delete(items[index])
                
                fetchItems().forEach { print($0.date) }
                
            }
            
        }
        
    }
    
    func fetchItem(uuid: UUID) -> HourAndMinute {
        
        do {
            
            let descriptor = FetchDescriptor<HourAndMinute>(
                predicate: #Predicate { item in item.uuid ==  uuid },
                sortBy: [SortDescriptor(\.date, order: .forward)]
            )
            
            let items = try self.context.fetch(descriptor)
            
            return items.first ?? HourAndMinute()
            
        } catch {
            
            fatalError("\(error)")
            
        }
        
    }
    
    //bring all of HourAndMinute sorted by Date and asending.
    func fetchItems() -> [HourAndMinute] {
        
        do {
            
            let descriptor = FetchDescriptor<HourAndMinute>(
                sortBy: [SortDescriptor(\.date, order: .forward)]
            )
            
            let items = try self.context.fetch(descriptor)
            
            return items
            
        } catch {
            
            fatalError("\(error)")
            
        }
        
    }
    
    func saveContext() {
        
        do {
            
            try self.context.save()
            
        } catch {
            
            fatalError("\(error)")
            
        }
        
    }
    
    //save editing item on InputView or creating new, or is called conflictAlert. "overlap" means items' dates' overlap. when overlap, cant save item. then call conflictAlert.
    func saveItem(indexUUID: UUID, item: HourAndMinute, type: EditorialType) -> Bool? {
        
        let items = self.fetchItems()
        
        //when dates of items overlap, "overlap" not 0
        let overlap = items
            .filter { $0.date == item.date }
            .count
        
        let updateItem = self.fetchItem(uuid: indexUUID)
    
        //EditorialType
        
        //when ".add", dont overlap items and title is blank, can insert new item of "HourAndMinute". then new item's title is "Constant.other".
        if(type == .add && overlap == 0 && item.title == Constant.blank) {
            
            blankTitleNewItem()
            
            return nil
            
            //when ".add", dont overlap items and title is blank, can insert new item of "HourAndMinute". then new item's title is "self.title".
        } else if(type == .add && overlap == 0 && item.title != Constant.blank) {
            
            otherTitleNewItem()
            
            return nil
            
            //when ".add", and if overlap items, that conflict SwiftData.
        } else if(type == .add && overlap != 0) {
            
            conflictAlert()
            
            return true
            
            //if variables of "HourAndMinute" dont change anything, simply dismiss.
        } else if(type == .edit && updateItem.checkMarks == item.checkMarks && updateItem.date == item.date && updateItem.title == item.title) {
            
            noChangeEditItem()
            
            return nil
            
            //when ".edit", and dont overlap items, need to save item. because in this case, "checkMarks" or "date" was changed and "title" was inserted blank necessarily. item's title is inserted "Constant.other".
        } else if(type == .edit && overlap == 0 && item.title == Constant.blank) {
            
            blankEditItem()
            
            return nil
            
            //when ".edit", and dont overlap items, need to save item. because in this case, "checkMarks" or "date" or "title" was changed necessarily. item's title is inserted "self.title".
        } else if(type == .edit && overlap == 0 && item.title != Constant.blank) {
            
            editTitleItem()
            
            return nil
            
            //when ".edit", and overlap items, dont change "date", "title" is inserted blank, need to save item. in this case, changed "checkMarks" and "title".
        } else if(type == .edit && overlap != 0 && item.date == updateItem.date) {
            
            editCheckmarkAndTitleItem()
            
            return nil
            
        } else {
            
            conflictAlert()
            
            return true
            
        }
        
        func blankTitleNewItem() {
            
            print("0")
            
            let newItem = HourAndMinute(
                checkMarks: item.checkMarks,
                date: item.date,
                isOn: item.isOn,
                title: Constant.other,
                uuid: item.uuid
            )
            
            self.context.insert(newItem)
            
        }
        
        func otherTitleNewItem() {
            
            print("1")
            
            let newItem = HourAndMinute(
                checkMarks: item.checkMarks,
                date: item.date,
                isOn: item.isOn,
                title: item.title,
                uuid: item.uuid
            )
            
            self.context.insert(newItem)
            
        }
        
        func conflictAlert() {
            
            print("2")
            
        }
        
        func noChangeEditItem() {
            
            print("3")
            
        }
        
        func blankEditItem() {
            
            print("4")
            
            updateItem.checkMarks = item.checkMarks
            updateItem.date = item.date
            updateItem.isOn = item.isOn
            updateItem.title = Constant.other
            
            self.saveContext()
            
        }
        
        func editTitleItem() {
            
            print("5")
            
            updateItem.checkMarks = item.checkMarks
            updateItem.date = item.date
            updateItem.isOn = item.isOn
            updateItem.title = item.title
            
            self.saveContext()
            
        }
        
        func editCheckmarkAndTitleItem() {
            
            print("6")
            
            updateItem.checkMarks = item.checkMarks
            updateItem.date = item.date
            updateItem.isOn = item.isOn
            updateItem.title = item.title
            
            self.saveContext()
            
        }
        
    }
    
}
