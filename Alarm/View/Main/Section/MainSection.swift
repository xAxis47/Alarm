//
//  MainSection.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftData
import SwiftUI

//this section is complex a little.
struct MainSection: View {
    
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
                    
                    let index = items.firstIndex(of: item) ?? 100
                    
                    //item is HourAndMinute. when header and item's title are equeal, cells be exported
                    if(header == item.title) {
                        
                        //"time" indicate when alarm will ring on the day.
                        let time = self.vm.pickUpHourAndMinuteString(date: item.date)
                        
                         //"dayOfTheWeek" express when during the week will ring.
                         let dayOfTheWeek = self.vm.pickUpDaysString(checkMarks: item.checkMarks)
                        
                        Button(action: {
                            
                            self.vm.tapAlarmCell(uuid: item.uuid)
                            
                        }) {
                            
                            Toggle(isOn: Bindable(item).isOn) {
                               
                               VStack {
                                      
                                   Text(time)
                                       .font(.largeTitle)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .accessibilityIdentifier("\(Identifier.main.time)_\(index)")
                                   
                                   Text(dayOfTheWeek)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .accessibilityIdentifier("\(Identifier.main.dayOfTheWeek)_\(index)")
                                   
                               }
                               
                            }
                            .padding(6)
                            .onChange(of: item.isOn) {
                               
                                //when toggle is changed, register notification again.
                                self.vm.changeToggle()
                               
                            }
                            .accessibilityIdentifier("\(Identifier.main.toggle)_\(time)")
                               
                        }
                        .foregroundStyle(.foreground)
                        .accessibilityIdentifier("\(Identifier.main.cellButton)_\(time)")

                    }
                    
                }
                .onDelete(perform: self.vm.deleteItems)
                
            }, header: {
                
                Text(header)
                    .font(.title)
                
            })
            .accessibilityIdentifier("\(header)_\(Identifier.main.mainSection)")
        }
        
    }
    
}

#Preview {
    
    return MainSection()
        .environmentObject(AlarmViewModel())
    
}
