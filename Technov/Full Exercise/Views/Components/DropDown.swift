//
//  SettingsView.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/23/22.
//

import SwiftUI

//in the future we can make the drop down move generic so it can be used in many scenarios.

enum Game: String, CaseIterable, Identifiable, CustomStringConvertible {
    case multipleChoice
    case voiceRecognition
    case typed
    
    var description: String {
        switch self {
            case .multipleChoice:
                return "Multiple Choice"
            case .voiceRecognition:
                return "Voice Recognition"
            case .typed:
                return "Type"
        }
    }

    var id: String { self.rawValue }
}

struct DropDown: View {
    @StateObject var selectedExcersise = SelectedExcersise()
    @State var expand = false
    @State public var selectedGame: Game = .multipleChoice
    @State var buttonText = Game.multipleChoice.description
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text(buttonText).multilineTextAlignment(.center).font(.system(size: 15))
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                
            }.onTapGesture {
                self.expand.toggle()
            }
            
            if expand {
                ForEach(Game.allCases) { gameType in
                    Button(gameType.description) {
                        buttonText = gameType.description
                        selectedGame = gameType
                        selectedExcersise.excersiseType = gameType
                        
                        print("selected game: \(selectedGame)")
                        print("selected excersise: \(selectedExcersise.excersiseType)")
                        self.expand.toggle()
                    }
                }
            }
            
        }
        .padding(20)
        .background(expand ? Color("ButtonOutline").opacity(0.5) : Color("ButtonOutline"))
        .cornerRadius(20)
        .animation(.spring())
        .foregroundColor(Color("ButtonTextColor"))
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
