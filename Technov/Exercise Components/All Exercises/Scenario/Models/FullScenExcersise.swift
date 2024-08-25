//
//  FullScenExcersise.swift
//  Technov
//
//  Created by user209063 on 4/21/22.
//

import Foundation
struct FullScenExcersise {
    private let questions = ScenQuestion.allQuestions.shuffled()
    let questionsTotal = ScenQuestion.allQuestions.count
    //can still change variable locally, but only read outside
    private(set) var currentQuestionIndex = 0

    
    var currentQuestion: ScenQuestion {
        questions[currentQuestionIndex]
    }
    
    mutating func advanceGameState() {
        currentQuestionIndex += 1
    }
}
