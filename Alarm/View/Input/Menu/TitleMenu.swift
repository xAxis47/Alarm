//
//  TitleMenu.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftData
import SwiftUI

//when tap the button of title menu, TextField is filled that title.
struct TitleMenu: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    @Query(sort: [SortDescriptor(\HourAndMinute.date)]) private var items: [HourAndMinute]
    
    var body: some View {
        
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
        .accessibilityIdentifier("title_menu")
        
    }
}

#Preview {
    
    TitleMenu()
        .environmentObject(AlarmViewModel())

}
