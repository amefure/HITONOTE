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
    @Persisted var imagePath: String = ""      // 画像パス
    @Persisted var memo: String = ""           // メモ

    static var demoPerson: Person {
        let person = Person()
        person.name = "吉田　真紘"
        person.ruby = "よしだ　真紘"
        person.work = "デザイナー"
        person.birthday = Date()
        person.tell = "090-XXXX-XXXX"
        person.mail = "sample@sample.com"
        person.imagePath = ""
        person.memo = "これはメモです。"
        return person
    }
}
