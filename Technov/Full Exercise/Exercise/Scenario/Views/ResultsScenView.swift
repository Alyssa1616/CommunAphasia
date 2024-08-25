//
//  ScenResults.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 4/19/22.
//

import SwiftUI

struct ResultsScenView: View {
    var RSVM: ResultsScenViewModel
    @State var isGoClicked = false
    
    private var phraseNavigationLink : some View {
        NavigationLink(destination: ExerciseView(), isActive: $isGoClicked, label: {
            EmptyView()
        })
    }
    
    var body: some View {
            VStack(spacing: 30) {
                Text("Results").bold().font(.system(size: 30))
                Spacer()
                
                Text(RSVM.scenariosText)
                Text(RSVM.wordsPracticedText)
                
                Spacer()
                
                FowardButton(text: "Done") {
                    isGoClicked = true
                    print(isGoClicked)
                    
                }
                
            }.padding(.vertical, 50)
            .background(phraseNavigationLink)
            .navigationBarHidden(true)
        }
}


struct ResultsScenView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(ResultsVM: ResultsViewModel(isCorrect: (9,8)))
    }
}

