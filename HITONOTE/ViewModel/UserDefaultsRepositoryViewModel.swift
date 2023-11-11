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
    
    /// 取得
    public func setDisplayAllItem() {
        isRuby = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.RUBY_KEY)
        isGender = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.GENDER_KEY)
        isCharacter = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.CHARACTER_KEY)
        isWork = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.WORK_KEY)
        isBirthday = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.BIRTHDAY_KEY)
        isTell = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.TELL_KEY)
        isMail = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.MAIL_KEY)
        isMemo = userDefaultsRepository.getDisplayItem(key: UserDefaultsKey.MEMO_KEY)
    }

}
