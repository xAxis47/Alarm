//
//  Identifier.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/26.
//

enum Identifier {
    
    enum main {
        
        static let dayOfTheWeek: String = "main_day_of_the_week_Label"
        static let time: String = "main_time_Label"
        
        //cell's model is "\(.cellButton)_\(time)". time show when the timer go off.
        static let cellButton: String = "main_cell_button"
        static let plusButton: String = "main_plus_button"
        static let stopButton: String = "main_stop_button"
        
        static let list: String = "main_list"
        
        static let mainSection: String = "main_section"
        static let blankSection: String = "main_ablank_section"
        
        //toggle's model is "\(.toggle)_\(time)". time show when the timer go off.
        static let toggle: String = "main_toggle"
        
        static let view: String = "main_view"
        
    }
    
    enum input {
        
        static let datepicker: String = "input_datepicker"
        static let menu: String = "input_menu"
        static let navigationLink: String = "input_navigationLink"
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
        
        //button's model is "\(.button)_\(index)". index means mark list's index.
        static let button: String = "mark_button"
        
        static let image: String = "mark_image"
        
        static let list: String = "mark_list"
        
        static let view: String = "mark_view"
        
    }
    
}
