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
//        let list = self.vm.prepareList(items: items)
        let items: [[HourAndMinute]] = self.vm.prepareItems(items: items)
        
        //element is item of header array.
        ForEach(items, id: \.self) { array in
            
            let header = self.vm.filterHeader(items: array)
            
            //Section be created for each header.
            Section(content: {
                
                //make cells in the section.
                ForEach(array) { item in
                
                    let index = array.firstIndex(of: item) ?? 100
                    
                    //"time" indicate when alarm will ring on the day.
                    let time = self.vm.pickUpTime(date: item.date)
                    
                     //"dayOfTheWeek" express when during the week will ring.
                     let dayOfTheWeek = self.vm.pickUpDayOfTheWeek(checkMarks: item.checkMarks)
                    
                    Button(action: {
                        
                        self.vm.tapAlarmCell(uuid: item.uuid)
                        
                    }) {
                        
                        Toggle(isOn: Bindable(item).isOn) {
                           
                           VStack {
                                  
                               Text(time)
                                   .font(.custom("bold", size: 48))
                                   .frame(maxWidth: .infinity, alignment: .leading)
                                   .accessibilityIdentifier("\(Identifier.main.time)_\(index)")
                               
                               Text(dayOfTheWeek)
                                   .font(.footnote)
                                   .frame(maxWidth: .infinity, alignment: .leading)
                                   .accessibilityIdentifier("\(Identifier.main.dayOfTheWeek)_\(index)")
                               
                           }
                           
                        }
                        .padding(6)
                        .onChange(of: item.isOn) {
                           
                            //when toggle is changed, register notification again.
                            self.vm.changeToggle()
                           
                        }
                        .accessibilityIdentifier("\(Identifier.main.toggle)_\(index)")
                           
                    }
                    .foregroundStyle(.foreground)
                    .accessibilityIdentifier("\(Identifier.main.cellButton)_\(index)")

                    
                }
                .onDelete(perform: self.vm.deleteItems)
                
            }, header: {
                
                Text(header)
                    .font(.title)
                
            })
            .accessibilityIdentifier("\(Identifier.main.mainSection)_\(header)")
        }
        
    }
    
}

#Preview {
    
    return MainSection()
        .environmentObject(AlarmViewModel())
    
}
