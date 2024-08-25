//
//  MessageReceived.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import CoreLocation
 
struct MessageRecieved: View {
    let recievedMessage : Message
    let profile : Profile
    
    var body: some View {
        HStack {
            Text("")
                .padding(1)
            Text(recievedMessage.message)
                .font(.system(size: 22))
                .foregroundColor(Color.black)
                .padding(.leading, 15).padding(.top, 5).padding(.bottom, 5).padding(.trailing, 15)
                .background(Color.gray)
                .cornerRadius(8.0)
            Spacer()
        }
        
    }
    
}
 
struct MessageRecieved_Previews: PreviewProvider {
    static var previews: some View {
        MessageRecieved(recievedMessage: Message(message: "I'm good. How are you?", sent: false, sender: "", receiver: "", number: 0), profile: Profile(id: "", password: "", email: "", username: "Marie Curie", ratings: [], bio: "", photo: "smiley", patients: [])).environmentObject(Storing())
    }
}
