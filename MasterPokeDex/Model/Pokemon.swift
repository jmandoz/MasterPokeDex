//
//  Pokemon.swift
//  MasterPokeDex
//
//  Created by Jason Mandozzi on 6/25/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
//Each dictionary that we want to pull must be their own struct in order to access the key value pairs - must be Decodable
struct Pokemon: Decodable {
    //Used CondingKeys in order to rename the data we want
    //Must be exhaustive since there are mulitple properties in the model
    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case sprites = "sprites"
    }
    //Declaring the data we want to pull from JSON - must match exact
    let name: String
    let id: Int
    let abilities: [Abilities]
    let sprites: Sprite
}

struct Sprite: Decodable {
    let image: URL
    
    private enum CodingKeys: String, CodingKey {
        case image = "front_shiny"
    }
}

struct Abilities: Decodable {
    let ability: Ability
    struct Ability: Decodable {
        let name: String
    }
}
