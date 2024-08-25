//
//  GetUnsplashPhoto.swift
//  PhraseComp
//
//  Created by Sophie Strausberg on 4/7/22.
//

import Foundation
class GetUnsplashPhoto: ObservableObject {
    @Published var stringURL : String = ""
    
    init() {}
    
    func updateData(key: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&query=\(key)&client_id=gjPdR0RCeXlLUj2ZgtfeYst8a79uHaJH5eKjYhAhaco"
        
        if let safeURL = URL(string: urlString) {
            let request = URLRequest(url: safeURL)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    return
                }
                
                do {
                    let res = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                    let randInt = Int.random(in: 0...res.results.count-1)
                    self.stringURL = res.results[randInt].urls.small
                    
                } catch {
                    print(error)
                }
            }
            
            task.resume()
            
        }
    }
}
