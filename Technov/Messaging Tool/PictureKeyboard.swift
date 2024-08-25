//
//  PictureKeyboard.swift
//  Technov
//
//  Created by user209063 on 4/19/22.
//

import SwiftUI
import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import CoreLocation
import Foundation

class Card: Identifiable, Hashable {
    @ObservedObject var getUnsplashPhot = GetUnsplashPhoto()
    var id = UUID()
    
    
    var text: String
    func updatePic() {
        getUnsplashPhot.updateData(key: text)
    }
    
    func getPic() {
        
        
    }
    
    init(_ text: String) {
        self.text = text
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PictureKeyboard: View {
    @State var selectedArray: [Card] = []
    @State var options: [Card] = [Card("happy"), Card("sad"), Card("pen"), Card("pencil"), Card("travel"), Card("run")]
    @EnvironmentObject var storing : Storing
    var recepientProfile : Profile
    var mCount: Int
    @State var totCount = 0
    var sender : String
    var docReference: DocumentReference?
    @State var messageTexts = [String]()
    private var db = Firestore.firestore()
    @State var regularKey = false
    
    init(mICount: Int, sender: String, recepientProfile: Profile) {
        self.sender = sender
        self.mCount = mICount
        self.recepientProfile = recepientProfile
    }
    
    func findIndex(card: Card, arr: [Card]) -> Int {
        for ind in 0...arr.count {
            if arr[ind] === card {
                return ind
            }
        }
        return -1
    }
    func addData(message: String, sender: String, receiver: String) {
        let db = Firestore.firestore()
        let user = db.collection("chats").document()
        user.setData(["id":user.documentID, "message": message, "sender": sender, "receiver": receiver, "number" : mCount + totCount]) {
            (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("SUCCESS")
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                
                
                
                GeometryReader { geo in
                    ScrollView {
                        GeometryReader { geo in
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 3) {
                                ForEach(selectedArray, id: \.self){ card in
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                let ind = findIndex(card: card, arr: selectedArray)
                                                if ind != -1 {
                                                    selectedArray.remove(at: ind)
                                                }
                                                card.updatePic()
                                            })
                                            {
                                                Image(systemName: "x.circle")
                                                    .resizable()
                                                    .frame(width: 15.0, height: 15.0)
                                                    .padding(.all, 20)
                                            }
                                            
                                        }
                                        .onAppear(perform: {
                                            card.getUnsplashPhot.updateData(key: card.text)
                                        })
                                        
                                        
                                        AsyncImage(url: URL(string: card.getUnsplashPhot.stringURL)) { returnedImage in
                                            returnedImage
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 50)
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        
                                        Spacer()
                                        Text(card.text)
                                        
                                            .fontWeight(.bold).font(.custom("Helvetica Neue", size: 20))
                                        
                                        
                                        
                                        Spacer()
                                    }
                                    .frame(width: geo.size.width/3 - 13, height: geo.size.width/3 - 5)
                                    .border(Color.black, width: 1.5)
                                    .background(Color.gray)
                                    .cornerRadius(6)
                                    
                                }.padding(.bottom, 10)
                                
                            }
                            
                        }
                    }
                    
                }
            }
            
            Divider().background(Color.gray)
            
            VStack {
                GeometryReader { geo in
                    ScrollView {
                        GeometryReader { geo in
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 3) {
                                ForEach(options, id: \.self){ card in
                                    VStack {
                                        
                                        
                                        Text(card.text)
                                            .fontWeight(.bold).font(.custom("Helvetica Neue", size: 20))
                                        
                                            .onAppear(perform: {
                                                card.getUnsplashPhot.updateData(key: card.text)
                                            })
                                            .onTapGesture {
                                                self.selectedArray.append(Card("\(card.text)"))
                                                print(self.selectedArray)
                                            }
                                        
                                        AsyncImage(url: URL(string: card.getUnsplashPhot.stringURL)) { returnedImage in
                                            returnedImage
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 50)
                                            
                                        } placeholder: {
                                            ProgressView()
                                            
                                        }
                                        
                                    }
                                    
                                }.padding(.bottom, 10)
                                    .frame(width: geo.size.width/3 - 13, height: geo.size.width/3 - 5)
                                    .border(Color.black, width: 1.5)
                                    .background(Color.gray)
                                .cornerRadius(6)                        }
                            
                        }
                    }
                    
                }
            }
            Text("Send")
                .foregroundColor(Color.white)
                .frame(width: 150, height: 60)
                .background(Rectangle().fill(Color.blue).shadow(radius: 3).cornerRadius(8))
                .onTapGesture {
                    if self.selectedArray.count != 0 {
                        var message = ""
                        for str in selectedArray {
                            message += str.text + " "
                        }
                        self.totCount += 1
                        addData(message: message, sender: sender, receiver: recepientProfile.username)
                        self.selectedArray = []
                    }
                }.padding(.trailing, 10)
        }
    }
}

struct PictureKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        PictureKeyboard(mICount: 0, sender: "", recepientProfile: Profile(id: "", password: "", email: "", username: "", ratings: [], bio: "", photo: "smiley", patients: [])).environmentObject(Storing())
    }
}
