//
//  MessageSent.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI

struct MessageSent: View, Hashable {
    let sentMessage : Message
    let profile : Profile
    
    var body: some View {
        HStack {
            Spacer()
            Text(sentMessage.message)
                .font(.system(size: 22))
                .foregroundColor(Color.white)
                .padding(.leading, 15).padding(.trailing, 20).padding(.top, 5).padding(.bottom, 5)
                .background(Color.blue)
                
                .cornerRadius(8.0)
        }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(sentMessage)
    }
}
 
struct MessageSent_Previews: PreviewProvider {
    static var previews: some View {
        MessageSent(sentMessage: Message(message: "This message.", sent: true, sender: "", receiver: "", number: 0), profile: Profile(id: "", password: "", email: "meghan@gmail.com", username: "Meghan", ratings: [], bio: "", photo: "smiley", patients: [])).environmentObject(Storing())
    }
}
