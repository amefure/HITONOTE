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
    public func createPerson(name: String, order: Int) {
        try! realm.write {
            let Person = Person()
            realm.add(Person)
        }
    }
    
    public func updatePerson(id: ObjectId, name: String) {
        try! realm.write {
            let Persons = realm.objects(Person.self)
            if let Person = Persons.where({ $0.id == id }).first {
                Person.name = name
            }
        }
    }
    
    // Read
    public func readSinglePerson(id: ObjectId) -> Person {
        return realm.objects(Person.self).where({ $0.id == id }).first!
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
            let result = readSinglePerson(id: id)
            self.realm.delete(result)
        }
    }
    // MARK: - Person
    

    
}

