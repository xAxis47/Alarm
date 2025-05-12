//
//  MainView.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import SwiftUI
import SwiftData

//first view. there is cells of setted time. bottom is stop button of notification's sound.
struct MainView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var vm: AlarmViewModel
    
//    @Query(sort: [SortDescriptor(\HourAndMinute.date)]) private var items: [HourAndMinute]
//    
//    @Environment(\.modelContext) private var context


//    @Environment(AlarmViewModel.self) var vm
//    
//    init() {
//        print(items)
//    }
//    
    var body: some View {
        
        NavigationStack {
            
            //list of setted alarm. alarm can set 16 items. setted alarm button will transition to InputView. then EditorialType is ".edit".
            MainList()
            .sheet(isPresented: self.$vm.sheetIsPresented) {
                
                //InputView don't use NavigationLink. I prefer sheet. InputView can make alarm. and set time, repitition and title.
                InputView()
                
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    EditButton()
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    //PlusButton will transition to InputView. then EditorialType is ".add".
                    PlusButton()
                    
                }
                
            }
            // this alert is called when ammount of alarm is made over 16 items.
            .alert(Constant.limitAlertTitle, isPresented: self.$vm.limitAlertIsPresented) {
            } message: {
                
                Text(Constant.limitAlertBody)
                
            }
            
        }
        .accessibilityIdentifier(Identifier.mainView)
        
    }
    
}

#Preview {
    
    return MainView()
        .environmentObject(AlarmViewModel())
    
}
