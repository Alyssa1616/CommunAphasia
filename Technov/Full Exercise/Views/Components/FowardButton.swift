//
//  FowardButton.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 2/23/22.
//

import SwiftUI

struct FowardButton: View {
    @State var buttonText = "Next"
    let text: String
    let onClick: () -> Void
    var body: some View {
        Button(action: {
              onClick()
            }) {
                Text(text)
                    .frame(width: 320, height: 20, alignment: .center)
                    .padding()
                    .foregroundColor(Color("ButtonTextColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("ButtonOutline"), lineWidth: 15)
                )
                //darker
                    .background(Color("ButtonOutline"))
                    .cornerRadius(15)
            }
    }
}

struct FowardButton_Previews: PreviewProvider {
    static var previews: some View {
        FowardButton(text: "Next") {
            
        }
    }
}
