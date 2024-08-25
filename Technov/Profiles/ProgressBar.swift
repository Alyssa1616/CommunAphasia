//
//  ProgressBar.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI

// (1) Fix the sizing and color (basically the formating) of the progress bar to look like our sketch on the microsoft whiteboard

struct ProgressBar: View {
    @Binding var value: Float
    @State var progress = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ProgressView(value: progress)
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}
