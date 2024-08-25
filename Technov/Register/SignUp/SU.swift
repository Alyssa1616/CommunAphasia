//
//  SU.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import FirebaseFirestore
import Combine
import Firebase

struct SU: View {
    @State var username = ""
    @State var password1 = ""
    @State var password2 = ""
    @State var email = ""
    @State var isActive = false
    @State var showError = false
    @EnvironmentObject var storing: Storing
    @EnvironmentObject var firestoreReader : FirestoreReader
    private var db = Firestore.firestore()

    func fetchData() {
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
                let ratings = data["ratings"] as? [Int] ?? []
                let username = data["username"] as? String ?? ""
                let bio = data["bio"] as? String ?? ""
                let patients = data["patients"] as? [String] ?? []
                return Profile(id: id, password: password, email: email, username: username, ratings: ratings, bio: bio, photo: "", patients: patients)
            }
        }
        
    }
    
    func addData(email: String, password: String, username: String, ratings: [Int], bio: String, patients: [String]) {
        let db = Firestore.firestore()
        let user = db.collection("users").document()
        let id = user.documentID
        
        user.setData(["id": user.documentID, "email": email, "password": password, "username": username, "ratings": ratings, "photo": "", "patients": patients]) {
            (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            isActive = true
            storing.userUsernames.append(username)
            fetchData()
            storing.curUser = Profile(id: id, password: password, email: email, username: username, ratings: ratings, bio: bio, photo: "", patients: patients)
            print("SUCCESS")
        }
    }
    
    
    
    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    HStack(spacing: 15) {
                        Image(systemName: "person")
                            .foregroundColor(.black)
                        TextField("Name or Company Name", text: self.$username)
                    }.padding(.vertical, 20)
                    
                    Divider()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                        TextField("Enter Email Address", text: self.$email)
                    }.padding(.vertical, 20)
                    
                    Divider()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.black)
                        
                        SecureField("Password", text: self.$password1)
                    }.padding(.vertical, 20)
                    
                }.padding(.vertical)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 25)
                    .frame(width: .infinity, height: 450)
                
                SignUpButton()
                    .onTapGesture {
                        addData(email: email, password: password1, username: username, ratings: [], bio: "", patients: [])
                        self.isActive = true
                    }
                
                NavigationLink(destination: Home().navigationBarBackButtonHidden(true), isActive: $isActive) {
                    Text("")
                }
            }
        }
        
    }
}

struct SU_Previews: PreviewProvider {
    static var previews: some View {
        SU()
    }
}
