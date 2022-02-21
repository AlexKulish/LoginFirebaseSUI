//
//  LoginFirebaseSUIApp.swift
//  LoginFirebaseSUI
//
//  Created by Alex Kulish on 21.02.2022.
//

import SwiftUI
import Firebase

@main
struct LoginFirebaseSUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
