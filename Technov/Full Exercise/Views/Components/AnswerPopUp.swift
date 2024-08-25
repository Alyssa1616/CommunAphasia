//
//  answerPopUp.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/25/22.
//

import SwiftUI

struct AnswerPopUp: View {
    @State private var animationAmount = 1.0
    let isCorrect: Bool
    let userAnswer: String
    let correctAnswer: String
    let onClick: () -> Void
    
    var body: some View {
        
        Button(action: {
                onClick()
            }) {
                VStack(spacing: 30) {
                    VStack {
                        Text(isCorrect ? "Correct!" : "Incorrect.").bold()
                        if !isCorrect {
                            Text("You said: \(userAnswer)")
                            Text("Correct answer: \(correctAnswer)")
                        }
                    }.foregroundColor(.white)

                    
                    Text("Next")
                        .frame(width: 280, height: 15, alignment: .center)
                        .padding()
                        .foregroundColor(Color("ButtonTextColor"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("ButtonOutline"), lineWidth: 15)
                        )
                        .background(Color("ButtonOutline"))
                
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            }
            .frame(height: isCorrect ? 160 : 200)
            .background(isCorrect ? .green : .red)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isCorrect ? .green : .red, lineWidth: 15)
            )
            .edgesIgnoringSafeArea(.all)
            //animation not working
            .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
        
            .onAppear {
                animationAmount = 2
            }
    }
}

struct AnswerPopUp_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPopUp(isCorrect: true, userAnswer: "noen", correctAnswer: "Blue") {
            
        }
    }
}
