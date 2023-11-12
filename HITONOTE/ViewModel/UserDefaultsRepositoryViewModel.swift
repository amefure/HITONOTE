//
//  InputPersonViewModel.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/11.
//

import UIKit

class UserDefaultsRepositoryViewModel {
    
    static let sheard = UserDefaultsRepositoryViewModel()
    private let userDefaultsRepository = UserDefaultsRepository.sheard
    
    var isRuby: Bool = true          // ふりがな
    var isGender: Bool = true        // 性別
    var isCharacter: Bool = true     // キャラクター
    var isWork: Bool = true          // 職業
    var isBirthday: Bool = true      // 誕生日
    var isTell: Bool = true          // 電話
    var isMail: Bool = true          // メール
    var isMemo: Bool = true          // メモ
    
    var isCount: Int = 0             // インタースティシャル用カウント
    
    var isInitialBoot: Bool = false  // 初回起動フラグ
    
    /// 取得
    public func readingUserDefaultsAllItem() {
        
        /// 初回起動時かどうか識別
        isInitialBoot = userDefaultsRepository.getBoolData(key: UserDefaultsKey.APP_INITIAL_BOOT_FLAG)
        if !isInitialBoot {
            // 初回起動の場合は表示アイテムを全てONにする
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.RUBY_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.GENDER_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.CHARACTER_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.WORK_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.BIRTHDAY_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.TELL_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.MAIL_KEY, isOn: true)
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.MEMO_KEY, isOn: true)
            
            // 2回目起動以降にこの処理が走らないようにする
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.APP_INITIAL_BOOT_FLAG, isOn: true)
        }
        
        isRuby = userDefaultsRepository.getBoolData(key: UserDefaultsKey.RUBY_KEY)
        isGender = userDefaultsRepository.getBoolData(key: UserDefaultsKey.GENDER_KEY)
        isCharacter = userDefaultsRepository.getBoolData(key: UserDefaultsKey.CHARACTER_KEY)
        isWork = userDefaultsRepository.getBoolData(key: UserDefaultsKey.WORK_KEY)
        isBirthday = userDefaultsRepository.getBoolData(key: UserDefaultsKey.BIRTHDAY_KEY)
        isTell = userDefaultsRepository.getBoolData(key: UserDefaultsKey.TELL_KEY)
        isMail = userDefaultsRepository.getBoolData(key: UserDefaultsKey.MAIL_KEY)
        isMemo = userDefaultsRepository.getBoolData(key: UserDefaultsKey.MEMO_KEY)
        
        /// インタースティシャルカウント
        isCount = userDefaultsRepository.getIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY)
        
    }
    
    /// 取得
    public func getAppLockFlag() -> Bool {
        return userDefaultsRepository.getBoolData(key: UserDefaultsKey.APP_LOCK_KEY)
    }
    
    
    public func incrementCount() {
        isCount += 1
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY, value: isCount)
    }
    
    public func resetCount() {
        isCount = 0
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY, value: isCount)
    }
    
}
