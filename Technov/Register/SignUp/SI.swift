//
//  SI.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import grpc

struct SI: View {
    @State var username: String = ""
    @State var password: String = ""
    @State private var isActive: Bool = false
    @State var showError = false
    @EnvironmentObject var storing: Storing
    @State var active = false
    private var db = Firestore.firestore()

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Enter Email Address", text: self.$username)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                }.padding(.vertical)
            }.padding(.vertical)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 25)
            
            SignUpButton()
                .onTapGesture {
                    fetchData(e: username, p: password)
                    self.isActive = true
                    print(storing.curUser.username)
                }
                
            if showError {
                Text("Error: Username or password incorrect")
                    .foregroundColor(Color.white)
                    .padding(.all, 8.0)
                    .background(Color.red)
                    .cornerRadius(14.0)
            }
            
            NavigationLink(destination: Home().navigationBarBackButtonHidden(true), isActive: $active) {
                Text("")
            }.padding(.bottom, 100)
            
        }
    }
    
    func fetchData(e: String, p: String) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.storing.users = documents.map { (QueryDocumentSnapshot) -> Profile in
                let data = QueryDocumentSnapshot.data()
                
                let email = data["email"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let ratings = data["ratings"] as? [Int] ?? []
                let bio = data["bio"] as? String ?? ""
                let p = data["photo"] as? String ?? ""
                let patients = data["patients"] as? [String] ?? []
                return Profile(id: id, password: password, email: email, username: username, ratings: ratings, bio: bio, photo: p, patients: patients)
            }
            
            for x in self.storing.users {
                if x.email == e && x.password == p {
                    storing.curUser = x
                    active = true
                    print("Success")
                    return
                }
            }
            showError = true
        }
    }
}

struct SI_Previews: PreviewProvider {
    static var previews: some View {
        SI().environmentObject(Storing())
    }
}
