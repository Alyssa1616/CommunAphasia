//
//  SignUpButton.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI

struct SignUpButton: View {
    let rbgColor = Color(red: 10, green: 100, blue: 255)
    var body: some View {
        Text("SIGN IN")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(LinearGradient(gradient: .init(colors: [Color.blue, Color(UIColor.systemTeal), Color(UIColor.systemIndigo)]), startPoint: .leading, endPoint: .trailing)).cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 15)
    }
}

struct SignUpButton_Previews: PreviewProvider {
    static var previews: some View {
        SignUpButton()
    }
}
