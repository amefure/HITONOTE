//
//  RepositoryViewModel.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import UIKit

class RepositoryViewModel: ObservableObject {
    
    static let shared = RepositoryViewModel()
    private let repository = RealmRepository()
    
    @Published var people: Array<Person> = []
    
    public func readAllPerson() {
        let results = repository.readAllPerson()
        people.removeAll()
        
    }
    
    public func createPerson(name:String, order:Int) {
        repository.createPerson(name: name, order: order)
        self.readAllPerson()
    }

}
