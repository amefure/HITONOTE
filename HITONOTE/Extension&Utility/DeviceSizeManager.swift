//
//  DeviceSizeManager.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/12.
//

import UIKit

class DeviceSizeManager {

    static var deviceWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return window.screen.bounds.width
    }
    
    static var isSESize: Bool {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }
        if window.screen.bounds.height <= 667 {
            return true
        } else {
            return false
        }
    }
}
