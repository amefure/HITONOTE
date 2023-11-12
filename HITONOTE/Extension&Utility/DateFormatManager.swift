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
        df.dateFormat = L10n.dateFormat
        df.locale = Locale(identifier: L10n.dateLocale)
        df.calendar = Calendar(identifier: .gregorian)
    }
    
    public func getString(date: Date) -> String {
        return df.string(from: date)
    }

}
