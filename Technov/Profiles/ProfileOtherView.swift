//
//  ProfileOtherView.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import Foundation
import AVFoundation
import FirebaseFirestore


struct ProfileOtherView: View {
    @EnvironmentObject var storing: Storing
    var user: Profile = Profile(id: "", password: "", email: "", username: "", ratings: [], bio: "", photo: "", patients: [])
    @State private var showPopUp = false
    @State var picker = false
    @State var i = ""
    private var db = Firestore.firestore()
    @State var progressValue: Float = 0.0
    
    init(user: Profile) {
        self.user = user
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    
                    CircleImage(photo: user.photo)
        
                    
                    Spacer()
                    Text(user.username)
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(Color.blue)
                        .padding(.trailing, 100)
                    //change text size

                }.padding(.bottom, 100)
                /*
                Text("Link Account")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.blue).cornerRadius(4)
                    .offset(y: -40)
                    .padding(.bottom, 10)
                    .shadow(radius: 15)
                    .onTapGesture {
                        storing.curUser.patients.append(user.username)
                    }
                */
                // (1) ADD A Navigationlink (which is a button) here to link to the messaging page (you can look at other files for reference)
                
               // NavigationLink()
                
               // Spacer()
            
                // (2) GO INTO THE PROGRESS BAR FILE TO SEE WHAT TO DO THERE
                
                StatsView()
                    
                //ProgressBar(value: $progressValue).frame(height: 20)
                
                Spacer()

            }
        }
        
}

struct ProfileOther_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOtherView(user: Profile(id: "", password: "", email: "", username: "", ratings: [], bio: "", photo: "smiley", patients: [])).environmentObject(Storing())
    }
}


