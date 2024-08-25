//
//  Home.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import Foundation
import CoreLocation
 
struct Home: View {
    @EnvironmentObject var storing: Storing
    @State var selected = 1
    @State var searchText = ""
  
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(named: "Secondary")
    }
    var body: some View {
 
        TabView(selection: $selected) {
            ExerciseView()
                .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.tag(0)

            
            ContactList(name: storing.curUser.username)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Message")
                    }.tag(1)
            
            ProfileOtherView(user: storing.curUser)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }.tag(2)
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
    }
}
 
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(Storing())
    }
}

