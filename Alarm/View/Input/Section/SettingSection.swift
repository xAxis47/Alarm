//
//  SettingSection.swift
//  Alarms
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftData
import SwiftUI

//SettingSection is in the middle. RepititionCell decide the days of the week, and TitleCell decide title.
struct SettingSection: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    @Query(sort: [SortDescriptor(\HourAndMinute.date)]) private var items: [HourAndMinute]
    
    var body: some View {
        
        Section {
            
            NavigationLink(destination: {
                
                //set the days of the week on which the alarm will ring here.
                MarkView()
                
            }) {
                
                HStack {
                    
                    Text(Constant.repetition)
                        .accessibilityIdentifier(Identifier.repetition)
                    
                    Spacer()
                    
                    //show the days of the week. can show specific days of the week too.
                    Text(self.vm.pickUpDayOfTheWeek())
                        .foregroundStyle(.secondary)
                }
                
            }
            .accessibilityIdentifier(Identifier.navigationLink)
           
            HStack {
                
                //when tap title string, show title menu. once enter the title at InputView, it will appear in the menu. there is goodmorning on top of the menu always.
                
                Menu(content: {
                    
                    //After extracting the titles of the items, sort them in ascending order. exclude goodMorning and blank title.
                    let titles = self.vm.filterTitles(items: items)
                    
                    //the reason why exclude goodMorning by filter is because want to put goodMorning at the top on menu.
                    Button(action: {
                        
                        self.vm.setTitle(title: Constant.goodMorning)
                        
                    }) {
                        
                        Text("\(Constant.goodMorning)")
                        
                    }
                    
                    ForEach(titles, id: \.self) { title in
                    
                        Button(action: {
                            
                            self.vm.setTitle(title: title)
                            
                        }) {
                            
                            Text("\(title)")
                            
                        }
                        
                    }
                    
                }) {
                    
                    Text(Constant.title)
                    
                    
                }
                .foregroundStyle(.foreground)
                .accessibilityIdentifier(Identifier.menu)
                
                Spacer()
                
                //here register the title on the TextField.
                TextField(Constant.title, text: self.$vm.title)
                    .multilineTextAlignment(.trailing)
                    .accessibilityIdentifier(Identifier.textfield)
                    
                
            }
            
        }
        .accessibilityIdentifier(Identifier.settingSection)
        
    }
    
}

#Preview {
    
    SettingSection()
        .environmentObject(AlarmViewModel())
    
}
