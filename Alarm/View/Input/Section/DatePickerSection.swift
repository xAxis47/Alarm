//
//  DatePickerSection.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftUI

//simply there is DatePicker.
struct DatePickerSection: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    var body: some View {
        
        Section {
            
            //selection value comes from the Model.
            DatePicker(
                selection: self.$vm.date,
                displayedComponents: .hourAndMinute
            ) {

                Text(Constant.blank)
                
            }
            .datePickerStyle(.wheel)
            .labelsHidden()
            .environment(\.locale, Locale(identifier: Constant.japaneseIdentifier))
            .accessibilityIdentifier(Identifier.input.datepicker)
            
        }
        .accessibilityIdentifier(Identifier.input.datepickerSection)
        
    }
    
}

#Preview {
    
    DatePickerSection()
        .environmentObject(AlarmViewModel())
    
}
