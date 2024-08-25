//
//  ContentView.swift
//  ScenarioExcersise
//
//  Created by Sophie Strausberg on 4/19/22.
//

import SwiftUI
import UIKit
import Foundation
 
struct ScenarioExercise: View {
    @State var wordsUsed = 0
    @State var checkClicked = false
    @State var totCount = 0
    @State var messageTexts = [String]()
    @State var regularKey = false
    @State var gameOver = false
    var plax = true
    @StateObject var ScenVM = ScenViewModel()
    
    @State var selectedArray: [String] = []
    @State var options: [String] = ["I", "want", "to", "go", "the", "store"]
    
    func findIndex(card: String, arr: [String]) -> Int {
        for ind in 0...arr.count {
            if arr[ind] == card {
                return ind
            }
        }
        return -1
    }
 
    var body: some View {
        VStack {
            Text(ScenVM.questionText)
                .padding()
                .padding(.horizontal, 20)
                .onAppear {
                   options = ScenVM.questionWords
                }
        
            GeometryReader { geo in
                ScrollView {
                    GeometryReader { geo in
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 3) {
                            ForEach(selectedArray, id: \.self){ card in
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.options.append(card)
                                            let ind = findIndex(card: card, arr: selectedArray)
                                            if ind != -1 {
                                                selectedArray.remove(at: ind)
                                            }
                                        }) {
                                        Image(systemName: "x.circle")
                                                .resizable()
                                                .frame(width: 15.0, height: 15.0)
                                                .padding(.all, 20)
                                        }
                                    }
                                    Spacer()
                                    Text(card)
                                
                                        .fontWeight(.bold).font(.custom("Helvetica Neue", size: 20))
                                    
                                    Spacer()
                                }
                                        .frame(width: geo.size.width/3 - 13, height: geo.size.width/3 - 5)
                                        .border(Color.black, width: 1.5)
                                      //  .padding(.leading, 40)
                                    //    .padding(.trailing, 40)
                                        .background(Color.gray)
                                        .cornerRadius(6)
                                       // .shadow(radius: 5)
                                
                                
                            }.padding(.bottom, 10)
                        }
                        
                    }
                }
                
            }
    
        Divider().background(Color.gray)
        
        VStack {
            GeometryReader { geo in
                ScrollView {
                    GeometryReader { geo in
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 3) {
                            ForEach(options, id: \.self){ card in
                                Text(card)
                                    .fontWeight(.bold).font(.custom("Helvetica Neue", size: 20))
                                    .frame(width: geo.size.width/3 - 13, height: geo.size.width/3 - 5)
                                    .border(Color.black, width: 1.5)
                                  //  .padding(.leading, 40)
                                //    .padding(.trailing, 40)
                                    .background(Color.gray)
                                    .cornerRadius(6)
                                   // .shadow(radius: 5)
                                    .onTapGesture {
                                        self.selectedArray.append(card)
                                        let ind = findIndex(card: card, arr: options)
                                        if ind != -1 {
                                            options.remove(at: ind)
                                        }
                                    }
                            }.padding(.bottom, 10)
                        }
                        
                    }
                }
                
            }
        }
            
            if checkClicked == false {
                FowardButton(text: "Check") {
                    //what if they haven't selected anything?
//                    if let _ = selectedIndex {
//                        if PhraseVM.questionAnswers[selectedIndex!] == PhraseVM.questionCorrectAnswer {
//                            isCorrect.correct += 1
//                        } else {
//                            isCorrect.incorrect += 1
//                        }
//
//                        selectedIndex! += 0
//                        checkClicked.toggle()
//                    }
                    checkClicked.toggle()
                }
            } else {
                FowardButton(text: "Next") {
                    guard ScenVM.fullScenExcersise.currentQuestionIndex + 1 < ScenQuestion.allQuestions.count else {
                        print("GAME OVER")
                        checkClicked.toggle()
                        gameOver = true
                        return
                    }
                    
                    print("working")
                    ScenVM.advance()
                    wordsUsed += selectedArray.count
                    selectedArray = []
                    options = ScenVM.questionWords
                    checkClicked.toggle()
                    
                }
            }
        }
        .background(resultsNavigationLink)
        .navigationBarHidden(true)
    }
    private var resultsNavigationLink : some View {
        NavigationLink(destination: ResultsScenView(RSVM: ResultsScenViewModel(wordsUsed: wordsUsed, scenarios: ScenVM.questionNum)), isActive: .constant(gameOver), label: {
            EmptyView()
        })
        
    }
}
 
struct PictureKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioExercise()
    }
}

