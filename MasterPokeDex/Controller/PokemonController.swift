//
//  PokemonController.swift
//  MasterPokeDex
//
//  Created by Jason Mandozzi on 6/25/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class PokemonController {
    //Singelton
    static let shared = PokemonController()
    
    //Create the Pokemon
    //Completion handler allows you to check when things are completed
    func fetchPokemonWith(searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        //Base URL -> the soruce where we get the data
        let baseURL = URL(string: "https://pokeapi.co/api/v2")
        
        //Attach the pokemon URL using the path component
        let pokemonPathComponentURL = baseURL?.appendingPathComponent("pokemon")
        
        //Construct the final URL - adding on the final path component
        guard let finalURL = pokemonPathComponentURL?.appendingPathComponent(searchTerm.lowercased()) else {return}
        print(finalURL)
        
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            //Handle the error
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            //Check if there's data
            if let data = data {
                //decode the data
                do {
                    //Handle the data
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(pokemon)
                } catch {
                    print("error fetching the data: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            }
        } .resume()
        
    }
    
    func fetchPokemonImageWith(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        //since the image is a URL, you access the struct in your model to get the image URL
        let imageURL = pokemon.sprites.image
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            
            if let data = data {
                guard let pokemonImage = UIImage(data: data) else {return}
                completion(pokemonImage)
            }
        }.resume()
    }
}
