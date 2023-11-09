//
//  RepositoryViewModel.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import UIKit
import RealmSwift

class RepositoryViewModel: ObservableObject {
    
    static let shared = RepositoryViewModel()
    private let repository = RealmRepository()
    
    @Published var people: Array<Person> = []
    
    public func readAllPerson() {
        people.removeAll()
        let result = repository.readAllPerson()
        people = Array(result)
    }
    
    public func createPerson(name: String, ruby: String, work: String, birthday: Date, tell: String, mail: String, group: String, imagePath: String, memo: String) {
        repository.createPerson(name: name, ruby: ruby, work: work, birthday: birthday, tell: tell, mail: mail, group: group, imagePath: imagePath, memo: memo)
        self.readAllPerson()
    }
    
    public func updatePerson(id: ObjectId, name: String, ruby: String, work: String, birthday: Date, tell: String, mail: String, group: String, imagePath: String, memo: String) {
        repository.updatePerson(id: id, name: name, ruby: ruby, work: work, birthday: birthday, tell: tell, mail: mail, group: group, imagePath: imagePath, memo: memo)
        self.readAllPerson()
    }
    
    public func deletePerson(id: ObjectId) {
        repository.deletePerson(id: id)
        self.readAllPerson()
    }


}
