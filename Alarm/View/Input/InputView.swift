//
//  InputView.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import Foundation
import SwiftData
import SwiftUI

//this is sheet view. can set time, repitition and title here. there are two "EditorialType". create new in the case of ".add", edit data you created in the case of ".edit".
struct InputView: View {
    
    //when this environment variables is called, close sheet view
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var vm: AlarmViewModel
    
    @Query(sort: [SortDescriptor(\HourAndMinute.date)]) private var items: [HourAndMinute]
    
    var body: some View {
        
        NavigationStack {
            
            InputList()
            //conflictAlert is called when already registered time same input time. cant accept same time.
                .alert(Constant.conflictAlertTitle, isPresented: self.$vm.conflictAlertIsPresented) {
                } message: {
                    
                    Text(Constant.conflictAlertBody)
                    
                }
                .navigationTitle(Constant.timeSetting)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        
                        //when you tap cancel button, simply close InputView in the case of ".add", or trash newly input data and close InputView in the case of ".edit".
                        CancelButton()
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        //SaveButton will be create new or save after edit again
                        SaveButton()
                        
                    }
                    
                }
            
        }
        .accessibilityIdentifier(Identifier.inputView)
    
    }
    
}

#Preview {
    
    return InputView()
        .environmentObject(AlarmViewModel())

}
