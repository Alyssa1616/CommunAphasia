//
//  TechnovApp.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import Firebase

@main
struct TechnovApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            Login().environmentObject(Storing())
                .environmentObject(FirestoreReader())
                .environmentObject(Profile(id: "", password: "", email: "", username: "", ratings: [], bio: "", photo: "", patients: []))
            
        }
    }
}
