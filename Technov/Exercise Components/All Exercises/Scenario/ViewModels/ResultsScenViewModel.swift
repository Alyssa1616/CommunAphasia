//
//  ResultsScenViewModel.swift
//  Technov
//
//  Created by user209063 on 4/21/22.
//

import Foundation

struct ResultsScenViewModel {
    let wordsUsed: Int
    let scenarios : Int
    
    var wordsPracticedText: String {
        "You practiced \(wordsUsed) words!"
    }
    
    var scenariosText: String {
        "You completed \(scenarios) scenarios!"
    }
}
