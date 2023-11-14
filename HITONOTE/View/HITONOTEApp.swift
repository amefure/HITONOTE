//
//  HITONOTEApp.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

@main
struct HITONOTEApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if KeyChainRepository.sheard.getData().count == 4 {
                    /// キーチェーンにパスワードが保存されている場合
                    AppLockView()
                } else {
                    if UserDefaultsRepositoryViewModel.sheard.isInitialBoot {
                        /// 一度でもアプリを起動していれば
                        PersonListView()
                    } else {
                        /// アプリ初回起動時
                        SplashView()
                    }
                }
            }
        }
    }
}
