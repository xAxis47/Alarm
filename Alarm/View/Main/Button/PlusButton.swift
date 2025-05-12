//
//  PlusButton.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftData
import SwiftUI

//The PlusButton is placed in the top right of the screen. this button is for making alarm.
struct PlusButton: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
//    @Query(sort: [SortDescriptor(\HourAndMinute.date)]) private var items: [HourAndMinute]
    
    var body: some View {
        
        Button(action: {
            
            self.vm.tapPlusButton()
            
        }) {
            
            Label("", systemImage: "plus")
            
        }
        .accessibilityIdentifier(Identifier.plusButton)
        
    }
    
}

#Preview {
    
    return PlusButton()
        .environmentObject(AlarmViewModel())
    
}
