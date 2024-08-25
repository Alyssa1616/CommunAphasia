//
//  Login.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI

struct Login: View {
    @State private var drawUIColor: Color = Color(red: 177, green: 212, blue: 224)
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: .init(colors: [Color(red: 177/255, green: 212/255, blue: 224/255), Color(UIColor.systemTeal)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                if UIScreen.main.bounds.height > 800 {
                    HomeView()
                }
                else {
                    ScrollView(.vertical, showsIndicators: false) {
                        HomeView()
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

struct HomeView : View {
    @State var index = 0
    
    var body : some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 150, height: 150)
            
            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        self.index = 0
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                }.background(self.index == 0 ? Color.white : Color.clear).clipShape(Capsule())
                
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        self.index = 1
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                }.background(self.index == 1 ? Color.white : Color.clear).clipShape(Capsule())
            }.background(Color.black.opacity(0.1)).clipShape(Capsule())
                .padding(.top, 25)
            
            if self.index == 0 {
                SI()
            }
            else {
                SU()
            }
        }
    }
}
