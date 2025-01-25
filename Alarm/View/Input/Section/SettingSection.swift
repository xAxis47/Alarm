//
//  SettingSection.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftUI

//SettingSection is in the middle. RepititionCell decide the days of the week, and TitleCell decide title.
struct SettingSection: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    var body: some View {
        
        Section {
            
            NavigationLink(destination: {
                
                //set the days of the week on which the alarm will ring here.
                MarkView()
                
            }) {
                
                HStack {
                    
                    Text(Constant.repetition)
                    
                    Spacer()
                    
                    //show the days of the week. can show specific days of the week too.
                    Text(self.vm.pickUpDaysString())
                        .foregroundStyle(.secondary)
                }
                
            }
           
            HStack {
                
                //when tap title string, show title menu. once enter the title at InputView, it will appear in the menu. there is goodmorning on top of the menu always.
                TitleMenu()
                
                Spacer()
                
                //here register the title on the TextField.
                TextField(Constant.title, text: self.$vm.title)
                    .multilineTextAlignment(.trailing)
                    .accessibilityIdentifier("textfield")
                    
                
            }
            
        }
        .accessibilityIdentifier("setting_section")
        
    }
    
}

#Preview {
    
    SettingSection()
        .environmentObject(AlarmViewModel())
    
}
