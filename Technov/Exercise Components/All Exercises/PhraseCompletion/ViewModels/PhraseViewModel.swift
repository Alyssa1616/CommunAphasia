//
//  PhraseViewModel.swift
//  Technov
//
//  Created by user209063 on 4/21/22.
//

import Foundation

class PhraseViewModel: ObservableObject {
    //extra feature ideas: time,
    @Published var fullExcersise = FullExcersise()
    
    var questionText: String {
        fullExcersise.currentQuestion.text
    }
    
    var questionAnswers: [String] {
        fullExcersise.currentQuestion.answers
    }
    
    var questionAnswersIndices: Range<Int> {
        fullExcersise.currentQuestion.answers.indices
    }
    
    var questionCorrectAnswer: String {
        fullExcersise.currentQuestion.correctAnswer
    }
    
    func advance() {
        fullExcersise.advanceGameState()
    }
}

