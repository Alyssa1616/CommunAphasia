//
//  Question.swift
//  Technov
//
//  Created by user209063 on 4/21/22.
//

import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: String
    
    static let allQuestions = [
        Question(text: "How is your day?", answers: ["Good", "Bad", "Okay", "Perfect"].shuffled(), correctAnswer: "Perfect"),
        Question(text: "Skating on thin...", answers: ["Ice", "Water", "Snow", "Pigs"].shuffled(), correctAnswer: "Ice"),
        Question(text: "When pigs...", answers: ["Fly", "Jump", "Run", "Ski"].shuffled(), correctAnswer: "Fly"),
        Question(text: "Head over...", answers: ["Heels", "Toes", "Elbows", "Lunch"].shuffled(), correctAnswer: "Heels"),
        Question(text: "Break a...", answers: ["Leg", "Knee", "Hat", "Gloves"].shuffled(), correctAnswer: "Leg")
    ]
    
}

