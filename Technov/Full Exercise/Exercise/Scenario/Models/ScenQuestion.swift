//
//  Question.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/23/22.
//

import Foundation

struct ScenQuestion {
    let text: String
    let words: [String]
    
    static let allQuestions = [
        ScenQuestion(text: "You’re at a restaurant and your salad arrives. However, you don’t have any utensils. You turn to your waiter and say…", words: ["Give", "Me", "I", "Want", "Food", "Please", "You", "Will"]),
        ScenQuestion(text: "You are walking along the beach and you see a beautiful sunset. You look up at the sky and say...", words: ["Wow", "Pretty", "Pink", "Sun", "Sunset", "This", "is", "So", "And"]),
        ScenQuestion(text: "You are at the movie theater, but the person sitting next to you is talking so loudly that you can’t hear the movie. You turn to the person and say…", words: ["Excuse", "Me", "Quiet", "Please", "Be", "Rude", "You", "Are", "Being", "Loud"]),
    ]
    
}
