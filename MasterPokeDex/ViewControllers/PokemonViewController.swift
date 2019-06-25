//
//  PokemonViewController.swift
//  MasterPokeDex
//
//  Created by Jason Mandozzi on 6/25/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //DON"T FORGET TO SET THE SEARCHBAR DELEGATE
        pokemonSearchBar.delegate = self
    }
    //Creating the update views function to call in our searchbar function
    func updateViews(pokemon: Pokemon) {
        //anytime you are updating the view, you must revert back to the main thread
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name
            self.pokemonIdLabel.text = "\(pokemon.id)"
            self.pokemonAbilitiesLabel.text = pokemon.abilities[0].ability.name
        }
    }


}
extension PokemonViewController: UISearchBarDelegate {
    
    //performing 4 tasks at the same time using asynchronus tasks, hitting the network twice
    //search bar function that allows the data to be completed as text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //calling the fetch pokemon function from our controller to populate the search text - network call
        PokemonController.shared.fetchPokemonWith(searchTerm: searchText) { (pokemon) in
            //unwrapping the pokemon since there may not be a value
            guard let pokemon = pokemon else {return}
            //calling the fetch pokemon image function, calling the network for the image URL and using a completion handler
            PokemonController.shared.fetchPokemonImageWith(pokemon: pokemon, completion: { (image) in
                //updating the view, so we must go back to the main thread
                DispatchQueue.main.async {
                    //update the Image of the pokemon
                    self.pokemonSpriteImage.image = image
                }
            })
            //updating the views
            self.updateViews(pokemon: pokemon)
        }
    }
}//end of class
