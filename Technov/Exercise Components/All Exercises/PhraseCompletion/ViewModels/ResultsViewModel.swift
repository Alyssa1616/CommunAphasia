//
//  ResultsViewModel.swift
//  Technov
//
//  Created by user209063 on 4/21/22.
//

import Foundation

struct ResultsViewModel {
    let isCorrect: (correct: Int, incorrect: Int)
    
    var scoreText: String {
        "Score: \(isCorrect.correct) / \(isCorrect.incorrect + isCorrect.correct)"
    }
    
    var correctText: String {
        "Correct: \(isCorrect.correct)"
    }
    
    var incorrectText: String {
        "Incorrect: \(isCorrect.incorrect)"
    }
}

