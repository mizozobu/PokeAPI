//
//  PokemonList.swift
//  PokeAPI
//
//  Created by user144546 on 11/27/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import Foundation

import Foundation



class PokemonList {
    
    // Mark - Property
    public var shared: [Pokemon] = []
    
    // Mark - init
    init() {
        fetchPokemonList()
    }
    
    // Mark - Helper
    public func fetchPokemonList() {
        // https://medium.com/@fvaldivia/basic-api-request-with-swift-4-d8bf829524f
        // https://medium.com/@nimjea/json-parsing-in-swift-2498099b78f
        
        var pokemonListFromAPI: [Pokemon] = []
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error == nil {
                if let dataResponse = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                        if let dictionaryResponse = jsonResponse as? Dictionary<String, Any> {
                            if let results = dictionaryResponse["results"] as? [[String: Any]] {
                                for pokemonInfo in results {
                                    guard let name = pokemonInfo["name"] as? String else { return }
                                    guard let url = pokemonInfo["url"] as? String else { return }
                                    let pokemon = Pokemon(name: name, url: url)
                                    pokemonListFromAPI.append(pokemon)
                                }
                                self.shared = pokemonListFromAPI
                            }
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
