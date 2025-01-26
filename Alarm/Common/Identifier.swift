//
//  Identifier.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/26.
//

enum identifier {
    
    enum alarm {
        
        enum button {
            
            //cell's model is "\(.cell)_\(time)". time show when the timer go off.
            static let cell: String = "cell_button"
            static let plus: String = "plus_button"
            static let stop: String = "stop_button"
            
        }
        
        enum list {
            
            static let alarm: String = "alarm_list"
            
        }
        
        enum section {
            
            static let alarm: String = "alarm_section"
            static let blank: String = "blank_section"
            
        }
        
        enum toggle {
            
            //toggle's model is "\(.toggle)_\(time)". time show when the timer go off.
            static let alarm: String = "alarm_toggle"
            
        }
        
        enum view {
            
            static let alarm: String = "alarm_view"
            
        }
        
    }
    
}
