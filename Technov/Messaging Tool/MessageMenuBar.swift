//
//  MessageMenuBar.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import CoreLocation
 
struct MessageMenuBar: View {
    var profile : Profile
    var lastMessage = ""
    @EnvironmentObject var storing: Storing
    init(profile: Profile) {
        self.profile = profile
    }
    var body: some View {
        HStack() {
            VStack(spacing: 3.0) {
                CircleImage(photo: profile.photo)
                    .padding(.top, 210)
                    .padding(.bottom, 10)
                Text(profile.username).font(.custom("DINAlternate-Bold", size: 16)) //profile.username
                    .font(.system(size: 22))
                    .fontWeight(.regular)
                    .padding(.bottom, 10)
                Divider()
            }
        }.frame(width: 390.0, height: 20.0)
            .edgesIgnoringSafeArea(.top)
            //.edgesIgnoringSafeArea(.bottom)
    }
}
 
struct MessageMenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MessageMenuBar(profile: Profile(id: "", password: "", email: "", username: "Meghan", ratings: [], bio: "", photo: "Tree", patients: [])).environmentObject(Storing())
    }
}

