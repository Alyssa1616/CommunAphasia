//
//  SendingMessage.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
//import SDWebImage
import CoreLocation
import Foundation
 
struct SendingMessage: View {
    @EnvironmentObject var storing : Storing
    var recepientProfile : Profile
    @State var messages = [Message]()
    @State var message = ""
    var m = [Message]()
    var sender : String
    var docReference: DocumentReference?
    @State var messageTexts = [String]()
    private var db = Firestore.firestore()
    //@State var regularKey = false
    
    init(recepientProfile: Profile, sender: String, messages: [Message]) {
        self.recepientProfile = recepientProfile
        self.sender = sender
        self.m = messages
    }
    
    var body: some View {
        VStack {
            MessageMenuBar(profile: recepientProfile)
                .padding(.bottom, 50)
            Spacer()
            ScrollView {
                ForEach(self.m, id: \.self) { message in
                    
                    if message.sender == sender {
                        MessageSent(sentMessage: message, profile: self.storing.curUser).padding(.all, 5)
                    }
                    else {
                        MessageRecieved(recievedMessage: message, profile: self.recepientProfile)
                    }
                }
                
            }
            if storing.regularKeyboard {
                HStack {
                    TextField("Type Here", text: $message)
                        .padding(.leading)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: 300, height: 50)
                        )
                        .padding()
                    
                    Text("Send")
                        .foregroundColor(Color.white)
                        .frame(width: 90, height: 45)
                        .background(Rectangle().fill(Color.blue).shadow(radius: 3).cornerRadius(15))
                        .onTapGesture {
                            if self.message != "" {
                                self.messages += [Message(message: self.message, sent: true, sender: sender, receiver: recepientProfile.username, number: messages.count)]
                                print("THIS IS THE USERRRRNAMEEE \(storing.curUser.username)")
                                messageTexts.append(message)
                                addData(message: message, sender: sender, receiver: recepientProfile.username)
                                self.message = ""
                            }
                        }.padding(.trailing, 10)
                }
            }
            else {
                NavigationLink(destination: PictureKeyboard(mICount: m.count, sender: sender, recepientProfile: recepientProfile)) {
                    Text("Send Message")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color.blue).cornerRadius(8)
                        .offset(y: -40)
                        .padding(.bottom, -40)
                        .shadow(radius: 15)
                
                }
                //.navigationTitle("")
                   // .navigationBarHidden(true)
            }
        }
        
    }
    
    func printmes(_ mes: String) {
        print(mes)
    }
    
    func addData(message: String, sender: String, receiver: String) {
        let db = Firestore.firestore()
        let user = db.collection("chats").document()
        let id = user.documentID
        user.setData(["id":user.documentID, "message": message, "sender": sender, "receiver": receiver, "number" : m.count]) {
            (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("SUCCESS")
        }
    }
}
 
struct SendingMessage_Previews: PreviewProvider {
    static var previews: some View {
        SendingMessage(recepientProfile: Profile(id: "", password: "", email: "", username: "", ratings: [], bio: "", photo: "smiley", patients: []), sender: "", messages: []).environmentObject(Storing())
    }
}

