//
//  SettingsView.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/23/22.
//

import SwiftUI

//later we can use an environment variable to pass in a whole SelectedExcersise including game type, excersise type, ect.
//drop down can change game type

//take out drop down (put into its own view), use environment variable to pass in current game type???

struct SettingsView: View {
    //drop down isn't updating. drop down view model?
    @State var dropDown : DropDown
    @State var picturesOn = false
    @State var isGoClicked = false
    
    //SETTINGS
    @State var expand = false
    @State public var selectedGame: Game = .multipleChoice
    @State var buttonText = Game.multipleChoice.description
    
    @ObservedObject var getUnsplashPhoto = GetUnsplashPhoto()
    
    var body: some View {
//        NavigationView {
            VStack(spacing: 30) {
                Text("Settings").bold().multilineTextAlignment(.center).font(.system(size: 30))
                
                Spacer()
                HStack {
                    Text("Pictures" ).font(.system(size: 15))
                    Toggle(isOn: $picturesOn) {
                       
                    }.labelsHidden()
                    .tint(picturesOn ? Color("ButtonOutline") : .gray)
                    .onChange(of: picturesOn) { _ in
                        getUnsplashPhoto.updateData(key: "flower")
                        print(getUnsplashPhoto.stringURL)
                        PhotoSettings.pictures.toggle()
                    }
                }
                
                //DROP DOWN
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
                                
                                print("selected game: \(selectedGame)")
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
                
                Spacer()
                
                FowardButton(text: "Let's Go!") {
                    isGoClicked = true
                    print(isGoClicked)
                    print(dropDown.selectedGame)
                }
                
            }.padding(.vertical, 50)
                .background(phraseNavigationLink)
                .navigationBarHidden(false)
//        }
    }
    private var phraseNavigationLink : some View {
        NavigationLink(destination: getView(type: selectedGame), isActive: .constant(isGoClicked), label: {
            EmptyView()
        })
    }
    
    func getView(type: Game) -> some View {
        switch type {
            case .multipleChoice:
                return AnyView(PhraseView())
            case .voiceRecognition:
                return AnyView(PhraseVoiceView().environmentObject(SpeechRecognizer()))
            case .typed:
                return AnyView(PhraseView())
            default:
                return AnyView(PhraseView())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dropDown: DropDown())
    }
}
