//
//  CircleImage.swift
//  Technov
//
//  Created by user209063 on 2/22/22.
//

import SwiftUI
import Foundation
import Combine
import UIKit

struct CircleImage: View {
    var pho: String = "Image"
    @EnvironmentObject var storing: Storing
    init(photo: String) {
        self.pho = photo
    }
    
    var body: some View {
        var u = pho != "" ? pho : "smiley"
        VStack {
            Image(systemName: "person.fill")
                .data(url: URL(string: u)!)
                .resizable()
                .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3)
                .frame(width: 125, height: 125)
                .shadow(radius: 10).cornerRadius(5.0)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(photo: "Image").environmentObject(Storing())
    }
}

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
        }
        return self
            .resizable()
    }
}
