//
//  Profile.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import Foundation
import CoreLocation
import SwiftUI

class Profile : Identifiable, ObservableObject, Hashable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        var equal = false
        if lhs.id == rhs.id && lhs.password == rhs.password && lhs.email == rhs.email {
            equal = true
        }
        return equal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var password : String
    @Published var email : String
    @Published var id : String
    @Published var username : String
    @Published var ratings = [Int]()
    @Published var bio : String = ""
    @Published var posts = [String]()
    @Published var photo: String = "Tree"
    @Published var patients: [String]
    
    init(id: String, password: String, email: String, username: String, ratings: [Int], bio: String, photo: String, patients: [String]) {
        self.password = password
        self.id = id
        self.email = email
        self.username = username
        self.ratings = ratings
        self.bio = bio
        self.photo = photo
        self.patients = patients
    }
    
}
