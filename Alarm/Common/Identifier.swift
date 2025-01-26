//
//  Identifier.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/26.
//

enum identifier {
    
    enum alarm {
        
        //cell's model is "\(.cellButton)_\(time)". time show when the timer go off.
        static let cellButton: String = "alarm_cell_button"
        static let plusButton: String = "alarm_plus_button"
        static let stopButton: String = "alarm_stop_button"
        
        static let list: String = "alarm_list"
        
        static let alarmSection: String = "alarm_section"
        static let blankSection: String = "alarm_ablank_section"
        
        //toggle's model is "\(.toggle)_\(time)". time show when the timer go off.
        static let toggle: String = "alarm_toggle"
        
        static let view: String = "alarm_view"
        
    }
    
    enum input {
        
        static let datepicker: String = "input_datepicker"
        static let markCell: String = "input_mark_cell"
        static let menu: String = "input_menu"
        static let textfield: String = "input_textfield"
        
        static let cancelButton: String = "input_cancel_button"
        static let menuButton: String = "input_menu_button"
        static let saveButton: String = "input_save_button"
        
        static let list: String = "input_list"
        
        static let datepickerSection: String = "input_datepicker_section"
        static let settingSection: String = "input_setting_section"
        
        static let view: String = "input_view"
        
    }
    
    enum mark {
        
        static let list: String = "mark_list"
        
        static let view: String = "mark_view"
        
    }
    
}
