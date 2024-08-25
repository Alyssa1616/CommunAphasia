//
//  Message.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import Foundation

struct Message : Identifiable, Hashable {
    var id = UUID()
    var message : String
    var sent : Bool
    var sender : String
    var receiver : String
    var number: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }
}
