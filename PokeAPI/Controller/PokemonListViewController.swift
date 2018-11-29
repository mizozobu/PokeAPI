//
//  PokemonListViewController.swift
//  PokeAPI
//
//  Created by user144546 on 11/27/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

class PokemonListViewController: UITableViewController {
    private struct StoryBoard {
        static let cellIdentifier = "PokemonTableCellIdentifier"
        static let sequeIdentifier = "ShowPokemonDetail"
    }
    
    var pokemonList: [Pokemon] = PokemonList().shared
    
    // Mark - view life cycle
    override func viewDidLoad() {
        // FIXME: repalce with api data
        let p1 = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        let p2 = Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
        pokemonList = [p1, p2]
        pokemonList = pokemonList.sorted(by: { $0.url < $1.url })
    }
    
    // Mark - helper
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.sequeIdentifier {
            if let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
                if let indexPath = sender as? IndexPath {
                    let pokemon = pokemonList[indexPath.row]
                    pokemon.fetchDetail()
                    pokemonDetailVC.pokemon = pokemon
                }
            }
        }
    }
    
    // Mark - table view delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.cellIdentifier, for: indexPath)
        cell.textLabel?.text = pokemonList[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: StoryBoard.sequeIdentifier, sender: indexPath)
    }
}
