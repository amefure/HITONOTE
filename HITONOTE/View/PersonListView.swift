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
    @State var selectedGroup: String = "All"
    @State var isShowInput = false
    @State var isShowSetting = false
    
    var body: some View {
        NavigationStack {
            
            HeaderView(leadingIcon: "gearshape.fill", trailingIcon: "plus", leadingAction: { isShowSetting = true }, trailingAction: { isShowInput = true })
                .navigationDestination(isPresented: $isShowSetting) {
                    SettingView()
                }
            
            if repository.groups.count != 0 {                
                CustomHorizontalPicker(groups: repository.groups, selectedSegment: $selectedGroup)
                    .onChange(of: selectedGroup) { newValue in
                        if newValue != "All" {
                            repository.filteringGroup(group: newValue)
                        } else {
                            repository.readAllPerson()
                        }
                    }
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


/// 横スクロールカスタムピッカー
struct CustomHorizontalPicker: View {
    
    @State var groups: Array<String>
    @Binding var selectedSegment: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Spacer()
                ForEach(groups, id: \.self) { group in
                    Button {
                        withAnimation {
                            selectedSegment = group
                        }
                    } label: {
                        Text(group)
                    }.padding(10)
                        .frame(width: 100)
                        .background(selectedSegment == group ? Asset.Colors.themaGreen.swiftUIColor : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(selectedSegment == group ? .white : Asset.Colors.textColor.swiftUIColor)
                        .lineLimit(1)
                        .fontWeight(.bold)
                }
                Spacer()
            }
        }.padding(5)
            .background(Asset.Colors.systemFoundation.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .transition(.scale)
            .padding(.horizontal, 5)
            .compositingGroup()
            .shadow(color: Asset.Colors.opacityGray.swiftUIColor, radius: 3, x: 2, y: 3)
            .onAppear {
                if !groups.contains("All") {
                    groups.insert("All", at: 0)
                }
            }
    }
}


#Preview {
    PersonListView()
}
