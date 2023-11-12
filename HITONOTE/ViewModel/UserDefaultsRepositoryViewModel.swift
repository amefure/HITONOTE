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
    
    /// 取得
    public func setDisplayAllItem() {
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
