//
//  Pokemon.swift
//  PokeAPI
//
//  Created by user144546 on 11/27/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import Foundation

class Pokemon {
    
    // Mark - Properties
    var id: Int = -1
    var name: String
    var url: String
    var height: Int = -1
    var weight: Int = -1
    
    // Mark - Init
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    // Mark - helper
    public func populate(height: Int, weight: Int) {
        self.height = height
        self.weight = weight
    }
    
    public func fetchDetail() {
        let url = URL(string: self.url)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error == nil {
                if let dataResponse = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                        if let dictionaryResponse = jsonResponse as? Dictionary<String, Any> {
                            guard let height = dictionaryResponse["height"] as? Int else { return }
                            guard let weight = dictionaryResponse["weight"] as? Int else { return }
                            self.populate(height: height, weight: weight)
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }
        }
        task.resume()
    }
}
