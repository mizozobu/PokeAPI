//
//  PokemonDetailViewController.swift
//  PokeAPI
//
//  Created by user144546 on 11/28/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UITableViewController {
    
    // Mark - property
    var pokemon = Pokemon(name: "", url: "")
    
    // Mark - outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        nameLabel.text = pokemon.name
        heightLabel.text = "\(pokemon.height)"
        weightLabel.text = "\(pokemon.weight)"
    }
}
