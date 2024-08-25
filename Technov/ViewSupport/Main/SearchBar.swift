//
//  SearchBar.swift
//  Technov
//
//  Created by user209063 on 3/11/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State var searchText = ""
    @EnvironmentObject var storing: Storing
    @State private var isEditing = false
    @State private var showingState = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Add exercises") {
                    showingState.toggle()
                }
//                .sheet(isPresented: $showingState) {
//                    SheetView()
//                }
                
                NavigationLink(destination: Login()) {
                    Text("Sign Out")
                }.navigationBarTitle("")
                .navigationBarHidden(true)
                .padding(.trailing, 10)
            }
            
            HStack {
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay (
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                               
                            
                                if isEditing {
                                    Button(action: {
                                        self.text = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
                
                
            }
           
            if isEditing {
                Spacer()
                
                List(storing.users.filter({text.isEmpty ? true : $0.username.contains(text)})) {
                    item in
                    NavigationLink(destination: ProfileOtherView(user: item)) {
                        ZStack {
                            HStack {
                                CircleImage(photo: item.photo)
                                
                                VStack {
                                    Text(item.username)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width - 80.0, height: 180.0).background(Color(red: 177/255, green: 212/255, blue: 224/255, opacity: 0.5)).cornerRadius(8).padding(.bottom, 10).padding(.top, 10)
                            
                        
                        }
                    }
            
                }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }
        if !isEditing {
            List(findPatients(patientsArr: storing.curUser.patients)) {
                item in
            
                
              NavigationLink(destination: ProfileOtherView(user: item)) {
                    
                
                
                    ZStack {
                        HStack {
                            CircleImage(photo: item.photo)
                            
                            VStack {
                                Text(item.username)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 80, height: 250.0).background(Color(red: 177/255, green: 212/255, blue: 224/255, opacity: 0.5)).cornerRadius(8).padding(.bottom, 10)
                        
                       // NavigationLink()
                    }
                }
            }.onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    func findPatients(patientsArr: [String]) -> [Profile] {
        var arr: [Profile] = []
        for user in storing.users {
            for i in patientsArr {
                if user.username == i {
                    arr.append(user)
                }
            }
        }
        return arr
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("")).environmentObject(Storing())
    }
}
