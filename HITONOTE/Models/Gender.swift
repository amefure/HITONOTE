//
//  Gender.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/10.
//

import UIKit
import RealmSwift

enum Gender: Int, PersistableEnum, Identifiable, CaseIterable {
    var id:String{self.value}
    
    case man
    case woman
    case other
    case unknown
    
    public var value: String {
        switch self {
        case .man:
            return L10n.genderMan
        case .woman:
            return L10n.genderWoman
        case .other:
            return L10n.genderOther
        case .unknown:
            return L10n.genderUnknown
        }
    }
}
