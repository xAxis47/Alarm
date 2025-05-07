//
//  MarkList.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/08/24.
//

import SwiftUI

//MarkList needs "day" and "index". "day" is simply string of the day of the week, and "index" is for array "checkMarks" of Model.
struct MarkList: View {
    
    @EnvironmentObject private var vm: AlarmViewModel

    var body: some View {
       
        List {
            
            ForEach(0..<self.vm.checkMarks.count, id: \.self) { index in
                
                Button(action: {
                    
                    self.vm.tapMarkCell(index: index)
                    
                }) {
                    
                    HStack {
                        
                        Text("\(Constant.dayInitialsArray[index])")
                        
                        Spacer()
                        
                        Image(systemName: self.vm.insertSystemName(index: index))
                            .foregroundStyle(.orange)
                            .accessibilityIdentifier("\(Identifier.mark.image)_ \(index)")
                        
                    }
                    .padding()
                    
                }
                .foregroundStyle(.foreground)
                .listRowInsets(.init())
                .accessibilityIdentifier("\(Identifier.mark.button)_\(index)")

                
            }
            
        }
        .accessibilityIdentifier(Identifier.mark.list)
    
    }
        
}

#Preview {
    
    MarkList()
        .environmentObject(AlarmViewModel())
    
}
