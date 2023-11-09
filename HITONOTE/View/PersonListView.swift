//
//  ContentView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI
import PhotosUI

struct PersonListView: View {
    
    @ObservedObject var repository = RepositoryViewModel.shared
    
    var body: some View {
        NavigationStack {
            
            HeaderView(leadingIcon: "", trailingIcon: "", leadingAction: {}, trailingAction: {})
            
            List {
                ForEach(repository.people) { person in
                    NavigationLink {
                        DetailPersonView(person: person)
                    } label: {
                        Text(person.name)
                    }
                    
                }
            }
            
            NavigationLink {
                InputPersonView(person: nil)
            } label: {
                Text("Input")
            }
            
            NavigationLink {
                SettingView()
            } label: {
                Text("Setting")
            }

            

        }.onAppear {
            repository.readAllPerson()
        }
    }

}

#Preview {
    PersonListView()
}





