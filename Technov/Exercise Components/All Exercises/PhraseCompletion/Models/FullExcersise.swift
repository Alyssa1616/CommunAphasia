//
//  FullExcersise.swift
//  Technov
//
//  Created by user209063 on 4/21/22.
//

import Foundation
struct FullExcersise {
    private let questions = Question.allQuestions.shuffled()
    //can still change variable locally, but only read outside
    private(set) var currentQuestionIndex = 0
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    mutating func advanceGameState() {
        currentQuestionIndex += 1
    }
}

