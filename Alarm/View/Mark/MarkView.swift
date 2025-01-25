//
//  MarkView.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import SwiftUI
import SwiftData

//On MarkView, represent the days of the week and isOn or not. in this view, decide which days of the week the sound will be played. if tap orange icon, become off.
struct MarkView: View {
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    var body: some View {
        
        VStack {
            
            //the days of the week, from Sunday to Saturday, and their icons are displayed.
            MarkList()
            //when there is no icon, will call alert. cant allow no icon at all because alarm will not ring.
            .alert(Constant.zeroTrueAlertTitle, isPresented: self.$vm.zeroTrueAlertIsPresented) {
            } message: {
                
                Text(Constant.zeroTrueAlertBody)
              
            }
            
        }
        .accessibilityIdentifier("mark_view")
        
    }
    
}

#Preview {
    
    MarkView()
        .environmentObject(AlarmViewModel())
    
}