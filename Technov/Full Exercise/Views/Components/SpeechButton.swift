//
//  SpeechButton.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/25/22.
//

import Speech
import SwiftUI
import Foundation

struct SpeechButton: View {
    
    @State var isPressed : Bool = false
    @State var actionPop : Bool = false
    @EnvironmentObject var SpeechRecognizer : SpeechRecognizer
    
    var body: some View {
        
        Button(action: {
            if self.SpeechRecognizer.getSpeechStatus() == "Denied" {
                self.actionPop.toggle()
            } else {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){self.SpeechRecognizer.isRecording.toggle()}// button animation
                self.SpeechRecognizer.isRecording ? self.SpeechRecognizer.startRecording() : self.SpeechRecognizer.stopRecording()
            }
        })
        {
            Image(systemName: "waveform")// Button Image
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .background(SpeechRecognizer.isRecording ? Circle().foregroundColor(.red).frame(width: 85, height: 85) : Circle().foregroundColor(Color("ButtonOutline")).frame(width: 70, height: 70))
        }
        
        .alert("Speech Recognition Denied", isPresented: $actionPop) {
            Button("OK") {
                // Handle acknowledgement.
            }
        } message: {
            Text("Access to speech recognition is denied. Please check your settings and try again.")
        }
    }//
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        SpeechButton().environmentObject(SpeechRecognizer())
    }
}
