//
//  ResultView.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/23/22.
//

import SwiftUI

struct ResultView: View {
    var ResultsVM: ResultsViewModel
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
                
                Text(ResultsVM.scoreText)
                Text(ResultsVM.correctText)
                Text(ResultsVM.incorrectText)
                
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


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(ResultsVM: ResultsViewModel(isCorrect: (9,8)))
    }
}
