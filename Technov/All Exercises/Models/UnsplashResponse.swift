//
//  UnsplashResponse.swift
//  Technov
//
//  Created by user209063 on 4/20/22.
//

import Foundation

struct UnsplashResponse: Codable {
//    let total: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    //array??
    let urls: URLS
}

struct URLS: Codable {
    let small: String
}
