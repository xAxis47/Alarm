//
//  MainList.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftData
import SwiftUI

//this list has 2 section and position header top of the section.
struct MainList: View {
    
    var body: some View {
        
        List {
            
            MainSection()
            
        }
        .accessibilityIdentifier(Identifier.main.list)
        
    }
    
}

#Preview {
    
    return MainList()
        .environmentObject(AlarmViewModel())
    
}
