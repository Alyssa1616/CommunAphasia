//
//  FirestoreReader.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import Foundation
import Firebase
import SwiftUI

class FirestoreReader : Identifiable, ObservableObject {
    @Published var userDictionary = [String : Profile]()
    @Published var user = ""
    @EnvironmentObject var storing: Storing
    private var db = Firestore.firestore()
}
