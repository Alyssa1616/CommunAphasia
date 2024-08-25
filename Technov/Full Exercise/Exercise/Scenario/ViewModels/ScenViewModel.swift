//
//  ScenViewModel.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 4/19/22.
//

import Foundation

class ScenViewModel: ObservableObject {
    //extra feature ideas: time,
    @Published var fullScenExcersise = FullScenExcersise()
    
    var questionText: String {
        fullScenExcersise.currentQuestion.text
    }
    
   var questionWords: [String] {
        fullScenExcersise.currentQuestion.words
    }
    
    var questionNum: Int {
        fullScenExcersise.questionsTotal
    }
    
    func advance() {
        fullScenExcersise.advanceGameState()
    }
}
