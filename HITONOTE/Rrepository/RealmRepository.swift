//
//  RealmRepository.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import UIKit
import RealmSwift

class RealmRepository {

    // MARK: - private property
    private let realm = try! Realm()
    
    // MARK: - Person
    public func createPerson(name: String, ruby: String, gender: String, character: String, work: String, birthday: Date?, tell: String, mail: String, group: String, imagePath: String, memo: String) {
        try! realm.write {
            let person = Person()
            person.name = name
            person.ruby = ruby
            person.gender = gender
            person.character = character
            person.work = work
            person.birthday = birthday
            person.tell = tell
            person.mail = mail
            person.group = group
            person.imagePath = imagePath
            person.memo = memo
            realm.add(person)
        }
    }
    
    public func updatePerson(id: ObjectId, name: String, ruby: String, gender: String, character: String, work: String, birthday: Date?, tell: String, mail: String, group: String, imagePath: String, memo: String) {
        try! realm.write {
            let people = realm.objects(Person.self)
            if let person = people.where({ $0.id == id }).first {
                person.name = name
                person.ruby = ruby
                person.gender = gender
                person.character = character
                person.work = work
                person.birthday = birthday
                person.tell = tell
                person.mail = mail
                person.group = group
                person.imagePath = imagePath
                person.memo = memo
            }
        }
    }
    
    
    private func readSinglePerson(id: ObjectId) -> Person? {
        if let person = realm.objects(Person.self).where({ $0.id == id }).first {
            return person
        }
        return nil
    }
    
    public func readAllPerson() -> Results<Person> {
        try! realm.write {
            let Persons = realm.objects(Person.self)
            // Deleteでクラッシュするため凍結させる
            return Persons.freeze().sorted(byKeyPath: "id", ascending: true)
        }
    }
    
    public func deletePerson(id: ObjectId) {
        try! self.realm.write{
            if let result = readSinglePerson(id: id) {
                self.realm.delete(result)
            }
        }
    }
    // MARK: - Person
    

    
}

