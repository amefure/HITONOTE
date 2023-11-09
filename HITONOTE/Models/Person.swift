//
//  Person.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import RealmSwift

class Person: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""           // 名前
    @Persisted var ruby: String = ""           // ルビ
    @Persisted var work: String = ""           // 職業
    @Persisted var birthday: Date = Date()     // 誕生日
    @Persisted var tell: String = ""           // 電話
    @Persisted var mail: String = ""           // メール
    @Persisted var group: String = ""          // グループ
    @Persisted var image: String = ""          // 画像
    @Persisted var memo: String = ""           // メモ

}
