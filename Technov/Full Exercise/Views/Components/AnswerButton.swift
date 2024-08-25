//
//  AnswerButton.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/25/22.
//

import SwiftUI

struct AnswerButton: View {
    let text: String
    let onClick: () -> Void
    var body: some View {
        
        Button(action: {
                onClick()
            }) {
                Text(text)
                    .frame(width: 320, height: 50, alignment: .center)
                    .padding()
                    .foregroundColor(Color("ButtonTextColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("ButtonOutline"), lineWidth: 15)
                )
            }
        }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(text: "Text", onClick: {
            
        })
    }
}
