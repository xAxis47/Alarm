//
//  AlarmSection.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftData
import SwiftUI

//this section is complex a little.
struct AlarmSection: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    @Query(sort: [SortDescriptor(\HourAndMinute.date)]) private var items: [HourAndMinute]
    
    init() {
        
    }

    var body: some View {
        
        //prepare header for section. header need to be sorted because the order is important.
        let list = self.vm.prepareList(items: items)
        
        //element is item of header array.
        ForEach(list, id: \.self) { header in
            
            //Section be created for each header.
            Section(content: {
                
                //make cells in the section.
                ForEach(items) { item in
                    
                    //item is HourAndMinute. when header and item's title are equeal, cells be exported
                    if(header == item.title) {
                        
                        Button(action: {
                            
                            self.vm.tapAlarmCell(uuid: item.uuid)
                            
                        }) {
                            
                             //"time" indicate when alarm will ring on the day.
                             let time = self.vm.pickUpHourAndMinuteString(date: item.date)
                            
                            Toggle(isOn: Bindable(item).isOn) {
                               
                                //"dayOfTheWeek" express when during the week will ring.
                                let dayOfTheWeek = self.vm.pickUpDaysString(checkMarks: item.checkMarks)
                               
                               VStack {
                                      
                                   Text(time)
                                       .font(.largeTitle)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                   
                                   HStack {
                                       
                                       Text(dayOfTheWeek)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       
                                   }
                                   
                               }
                               
                            }
                            .padding(6)
                            .onChange(of: item.isOn) {
                               
                                //when toggle is changed, register notification again.
                                self.vm.changeToggle()
                               
                            }
                            .accessibilityIdentifier("toggle_\(time)")
                               
                        }
                        .foregroundStyle(.foreground)

                    }
                    
                }
                .onDelete(perform: self.vm.deleteItems)
                
            }, header: {
                
                Text(header)
                    .font(.title)
                
            })
            .accessibilityIdentifier("alarm_section")
        }
        
    }
    
}

#Preview {
    
    return AlarmSection()
        .environmentObject(AlarmViewModel())
    
}
