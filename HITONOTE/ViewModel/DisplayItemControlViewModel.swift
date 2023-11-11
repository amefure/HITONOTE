//
//  DisplayItemControlViewModel.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/11.
//

import UIKit

class DisplayItemControlViewModel {
    
    
    private let userDefaultsRepository = UserDefaultsRepository.sheard
    
    /// 保存
    public func setDisplayItem(key: String, isOn: Bool) {
        userDefaultsRepository.setDisplayItem(key: key, isOn: isOn)
    }
    /// 取得
    public func getDisplayItem(key: String ) -> Bool {
        return userDefaultsRepository.getDisplayItem(key: key)
    }

}
