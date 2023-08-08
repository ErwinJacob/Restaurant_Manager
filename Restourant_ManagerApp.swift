//
//  Restourant_ManagerApp.swift
//  Restourant Manager
//
//  Created by Jakub Górka on 11/07/2023.
//

import SwiftUI
import FirebaseCore

@main
struct Restourant_ManagerApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
