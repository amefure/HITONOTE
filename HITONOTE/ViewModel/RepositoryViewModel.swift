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
    @Published var groups: Array<String> = []
    
    public func readAllPerson() {
        people.removeAll()
        let result = repository.readAllPerson()
        // 名前の昇順で並び替える
        people = Array(result.sorted(by: { $0.name < $1.name }))
        groups = people.filter({ $0.group != "" }).map({ $0.group })
    }
    
    public func createPerson(name: String, ruby: String, gender: Gender, character: String, work: String, birthday: Date?, tell: String, mail: String, group: String, imagePath: String, memo: String) {
        repository.createPerson(name: name, ruby: ruby, gender: gender, character: character, work: work, birthday: birthday, tell: tell, mail: mail, group: group, imagePath: imagePath, memo: memo)
        self.readAllPerson()
    }
    
    public func updatePerson(id: ObjectId, name: String, ruby: String, gender: Gender, character: String, work: String, birthday: Date?, tell: String, mail: String, group: String, imagePath: String, memo: String) {
        repository.updatePerson(id: id, name: name, ruby: ruby, gender: gender, character: character, work: work, birthday: birthday, tell: tell, mail: mail, group: group, imagePath: imagePath, memo: memo)
        self.readAllPerson()
    }
    
    public func deletePerson(id: ObjectId) {
        repository.deletePerson(id: id)
        self.readAllPerson()
    }

    public func filteringGroup(group: String) {
        readAllPerson()
        people = people.filter( {$0.group == group })
    }

}
