//
//  UserDefaultsRepository.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/11.
//

import UIKit

class UserDefaultsKey {
    
    static let GENDER_KEY = "GENDER_KEY"
    static let CHARACTER_KEY = "CHARACTER_KEY"
    static let WORK_KEY = "WORK_KEY"
    static let BIRTHDAY_KEY = "BIRTHDAY_KEY"
    static let TELL_KEY = "TELL_KEY"
    static let MAIL_KEY = "MAIL_KEY"
    static let MEMO_KEY = "MEMO_KEY"
    
}


class UserDefaultsRepository {
    
    static let sheard = UserDefaultsRepository()
    
    private let userDefaults = UserDefaults.standard
    /// 保存
    public func setDisplayItem(key: String, isOn: Bool) {
        userDefaults.set(isOn, forKey: key)
    }
    /// 取得
    public func getDisplayItem(key: String ) -> Bool {
        return userDefaults.bool(forKey: key)
    }
}
