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
    private let imageFileManager = ImageFileManager()
    @State var selectedGroup: String = ""
    @State var isShowInput = false
    @State var isShowSetting = false
    
    var body: some View {
        NavigationStack {
            
            HeaderView(leadingIcon: "gearshape.fill", trailingIcon: "plus", leadingAction: { isShowSetting = true }, trailingAction: { isShowInput = true })
                .navigationDestination(isPresented: $isShowSetting) {
                    SettingView()
                }
            
            if repository.groups.count != 0 {
                Picker(selection: $selectedGroup, label: Text(L10n.personGroup)) {
                    ForEach(repository.groups, id: \.self) { group in
                        Text(group)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            List {
                ForEach(repository.people) { person in
                    
                    NavigationLink {
                        DetailPersonView(person: person)
                    } label: {
                        HStack {
                            PersonImageView(image: imageFileManager.loadImage(name: person.imagePath), size: 30)
                            Text(person.name)
                                .fontWeight(.bold)
                        }
                    }
                    
                }
            }.listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background(.clear)
                    

        }.onAppear {
            repository.readAllPerson()
        }.sheet(isPresented: $isShowInput, content: {
            InputPersonView(person: nil)
        }).tint(Asset.Colors.themaGreen.swiftUIColor)
    }

}

#Preview {
    PersonListView()
}
