//
//  Extension.swift
//  Alarms
//
//  Created by Kawagoe Wataru on 2024/06/29.
//

import AVFoundation
import Foundation
import SwiftUI

extension Array {
    
    func add(_ object: Element) -> Array {
        var mutable = self
        mutable.insert(object, at: 0)
        return mutable
    }
    
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return viewControllers.count > 1
        
    }
    
}
