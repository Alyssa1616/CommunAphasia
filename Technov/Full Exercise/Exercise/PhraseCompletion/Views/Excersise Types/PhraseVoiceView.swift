//
//  PhraseVoiceView.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/25/22.
//

import SwiftUI

struct PhraseVoiceView: View {
    
    @EnvironmentObject var speechRecognizer: SpeechRecognizer
    
    @StateObject var PhraseVM = PhraseViewModel()
    @State var CheckClicked = false
    @State var correct = true
    //do in viewmodel
    @State var progress = 0.0
    //should probably be in view model but i dont care
    @State var isCorrect = (correct: 0, incorrect: 0)
    @State var gameOver = false
    
    var body: some View {
        VStack {
            
            ProgressView(value: progress).padding(.horizontal, 100.0)
            Spacer()
            Text(PhraseVM.questionText).bold().multilineTextAlignment(.center).font(.system(size: 30))
            
            VStack{
                Text(speechRecognizer.outputText ?? "")// prints results to screen
                    .font(.title)
                    .bold()
                
            }.frame(width: 300,height: 300)
                
            speechRecognizer.getButton()
                .padding(.bottom, 100)
            
            if CheckClicked == false {
                FowardButton(text: "Check") {
                    if let answer = speechRecognizer.outputText {
                        if answer == PhraseVM.questionCorrectAnswer {
                            isCorrect.correct += 1
                            correct = true
                        } else {
                            isCorrect.incorrect += 1
                            correct = false
                        }
                        
                        CheckClicked.toggle()
                    }
                }
            } else {
                //output will never be nil
                AnswerPopUp(isCorrect: correct, userAnswer: speechRecognizer.outputText ?? "", correctAnswer: PhraseVM.questionCorrectAnswer) {
                    guard PhraseVM.fullExcersise.currentQuestionIndex + 1 < Question.allQuestions.count else {
                        print("GAME OVER")
                        CheckClicked.toggle()
                        gameOver = true
                        return
                    }
                    
                    PhraseVM.fullExcersise.advanceGameState()
                        
                    progress = Double(Double(PhraseVM.fullExcersise.currentQuestionIndex) / Double(Question.allQuestions.count))
                    CheckClicked.toggle()
                    speechRecognizer.outputText = nil
                }
            }
        }
        
        .padding(.vertical, CheckClicked ? 0 : 60.0)
        .frame(width: .infinity, height: .infinity)
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(Color("TextColor"))
            .background(Color("BackgroundBlue"))
            .navigationBarHidden(true)
            .background(resultsNavigationLink)
    }
    
    private var resultsNavigationLink : some View {
        NavigationLink(destination: ResultView(ResultsVM: ResultsViewModel(isCorrect: isCorrect)), isActive: .constant(gameOver), label: {
            EmptyView()
        })
        
    }
}

struct PhraseVoiceView_Previews: PreviewProvider {
    static var previews: some View {
        PhraseVoiceView()
    }
}
