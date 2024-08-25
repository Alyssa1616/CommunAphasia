//
//  Storing.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class Storing: ObservableObject {
    @Published var users = [Profile]()
    @Published var userUsernames = [String]()
    @Published var curUser : Profile = Profile(id: "", password: "", email: "", username: "", ratings: [], bio: "", photo: "", patients: [])
    @Published var regularKeyboard = true
    //@Published var messagesChat =
}
