//
//  ContentView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI
import PhotosUI

struct PersonListView: View {
    
    // MARK: - Utility
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search:String = ""            // 検索テキスト
    @State private var selectedGroup: String = "All" // 選択されているグループ値
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "gearshape.fill", trailingIcon: "plus", leadingAction: { isShowSetting = true }, trailingAction: { isShowInput = true })
                .navigationDestination(isPresented: $isShowSetting) {
                    SettingView()
                }
            
            
            /// グループタブピッカー
            if repository.groups.count != 0 {
                CustomHorizontalPicker(groups: $repository.groups, selectedSegment: $selectedGroup)
                    .onChange(of: selectedGroup) { newValue in
                        if newValue == "All" {
                            repository.readAllPerson()
                        } else {
                            repository.filteringGroup(group: newValue)
                        }
                    }
            }
            
            /// 検索ボックス
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                TextField(L10n.personName + "...", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: search) { newValue in
                        if newValue.isEmpty {
                            repository.readAllPerson()
                        } else {
                            repository.filteringName(name: newValue)
                        }
                        
                    }
            }.padding(.horizontal, 20)
                .padding(.top, 10)
            
            
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
                .offset(y: -20)
            
            
            AdMobBannerView()
                .frame(height: 60)
            
        }.onAppear {
            repository.readAllPerson()
        }.sheet(isPresented: $isShowInput, content: {
            InputPersonView(person: nil)
        }).tint(Asset.Colors.themaGreen.swiftUIColor)
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
    
}


/// 横スクロールカスタムピッカー
struct CustomHorizontalPicker: View {
    
    @Binding var groups: Array<String>
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
                            .font(.system(size: 12))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                            .frame(width: 100)
                            .background(selectedSegment == group ? Asset.Colors.themaGreen.swiftUIColor : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(selectedSegment == group ? .white : Asset.Colors.textColor.swiftUIColor)
                            .lineLimit(1)
                            .fontWeight(.bold)
                    }
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
    }
}


#Preview {
    PersonListView()
}
