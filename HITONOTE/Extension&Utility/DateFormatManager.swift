//
//  DateFormatManager.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import UIKit

class DateFormatManager {

    public let df = DateFormatter()
    public let today = Date()

    init() {
        df.dateFormat = "yyyy年M月dd日"
        df.locale = Locale(identifier: "ja_JP")
        df.calendar = Calendar(identifier: .gregorian)
    }

    public func conversionJapaneseEraName() {
        df.calendar = Calendar(identifier: .japanese)
        df.dateFormat = "Gy年"
    }
    
    public func getString(date: Date) -> String {
        return df.string(from: date)
    }

}
