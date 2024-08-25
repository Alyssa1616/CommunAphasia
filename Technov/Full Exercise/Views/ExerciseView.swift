//
//  ExerciseView.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 4/8/22.
//

import SwiftUI

//make excersise & excersise type enum
//fix navigation link
//get rid of drop down
//code more types of excersises!!!
enum Exercises {
    case Phrase, Scenario
}
struct ExerciseView: View {
    @State var isExerciseSelected = false
    @State var selectedExercise: Exercises = .Phrase
    
    private var exerciseNavigationLink : some View {
        NavigationLink(destination: getDestination(), isActive: $isExerciseSelected, label: {
            EmptyView()
        })
    }
    
    func getDestination() -> some View {
        switch selectedExercise {
        case .Phrase:
            return AnyView(SettingsView(dropDown: DropDown()))
        case .Scenario:
            return AnyView(ScenarioExercise())
        }
    }
    
    var body: some View {
        var date = Date()
        NavigationView {
            ScrollView {
                //alignment
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            //MAKE DYNAMIC
                            Text("Saturday, January 15").foregroundColor(.gray).bold().font(Font.footnote)
                            Text("Exercises").bold().font(Font.largeTitle)
                        }
                        Spacer()
                        Button {
                            self.loadProfile()
                        } label: {
                            Image("Profile").resizable().frame(width: 50, height: 50, alignment: .trailing)
                        }.accentColor(.blue)

                    }.padding([.leading, .trailing, .top])
                    
                    Button {
                        self.selectedExercise = .Phrase
                        self.isExerciseSelected.toggle()
                    
                    } label: {
                        OutlineView(outlineColor: .teal, withImage: Image("Phrase-2"), name: "Phrase Completion", message: "Head-to-head football action!")
                    }.accentColor(.blue)
                    
                    Button {
                        self.selectedExercise = .Scenario
                        self.isExerciseSelected.toggle()
                    } label: {
                        OutlineView(outlineColor: .red, withImage: Image("Scenario"), name: "Scenario", message: "Head-to-head football action!")
                    }.accentColor(.blue)
                    
                }
                .background(exerciseNavigationLink)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
            .background(exerciseNavigationLink)
            .navigationBarHidden(true)
       
        
    }

    
    func loadProfile() {
        
    }

}

//assigned bool
//settings
struct OutlineView: View {
    var category: [Category]
    var outlineColor: Color
    var withImage: Image
    var name: String
    var message: String
    
    init(outlineColor: Color, withImage: Image, name: String = "", message: String = "", category: [Category] = []) {
        //add app icon property
        self.outlineColor = outlineColor
        self.withImage = withImage
        self.name = name
        self.message = message
        self.category = category
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                //fix later
                withImage.resizable().frame(height: 350).aspectRatio(contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                        .stroke(outlineColor, lineWidth: 25)
                    )
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("ASSIGNED")
                            .bold()
                        Image(systemName: "star.fill")
                    }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(outlineColor)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                        
                        Spacer()
    
               
                        Text(name).font(.system(size: 30))
                            .bold()
                            .foregroundColor(outlineColor.opacity(0.3))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 40)
                    }
            }
                        
        }.cornerRadius(30).padding().shadow(radius: 5)
    }
}


//ONCE WE HAVE MORE EXERCISES
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

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
