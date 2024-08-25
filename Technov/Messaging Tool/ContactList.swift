//
//  ContactList.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import Firebase
 
struct ContactList: View {
    @EnvironmentObject var storing : Storing
    var name: String
    
    init(name: String) {
        self.name = name
    }
    var body: some View {
        VStack {
            HStack {
                Text("Messages").font(.custom("DINAlternate-Bold", size: 33)).padding(.leading, 15).padding(.top, 10)
                Spacer()
                
                Toggle("", isOn: $storing.regularKeyboard)
                    .padding(.trailing, 15)
            }
            List(storing.users.filter{$0.username != name}){i in
                
                cellView(data: i, name: name, nameRec: i.username).environmentObject(Storing())
                
            }}.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
 
struct cellView : View {
    @EnvironmentObject var storing : Storing
    var data : Profile
    var db = Firestore.firestore()
    var name: String
    var nameRec : String
    
    init(data: Profile, name: String, nameRec: String) {
        self.data = data
        self.name = name
        self.nameRec = nameRec
    }
    
    @State var messages = [Message]()
    var body : some View {
        HStack(spacing: 12) {
            
            NavigationLink(destination: SendingMessage(recepientProfile: data, sender: name, messages: filterMessages(r: nameRec, s: name))) {
                CircleImage(photo: data.photo).padding(.trailing, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(data.username).fontWeight(.bold)
                }
                Spacer(minLength: 0)
                
            }.padding(.top, 10).padding(.bottom, 10)
        }
    }
    func fetchData() -> [Message]{
        db.collection("chats").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.messages = documents.map { (QueryDocumentSnapshot) -> Message in
                let data = QueryDocumentSnapshot.data()
                
                let message = data["message"] as? String ?? ""
                let sender = data["sender"] as? String ?? ""
                let receiver = data["receiver"] as? String ?? ""
                let num = data["number"] as? Int ?? 0
                
                return Message(message: message, sent: true, sender: sender, receiver: receiver, number: num)
            }
        }
        
        return messages
    }
    
    func filterMessages(r: String, s: String) -> [Message]{
        let mes = fetchData()
        var m = [Message]()
        for x in mes {
            if x.sender == s && x.receiver == r || x.sender == r && x.receiver == s {
                m.append(x)
            }
        }
        return m.sorted(by: { $0.number < $1.number })
    }
}
 
struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList(name: "").environmentObject(Storing())
    }
}

