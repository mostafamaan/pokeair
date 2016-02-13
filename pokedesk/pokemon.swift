//
//  pokemon.swift
//  pokedesk
//
//  Created by Mustafa on 2/11/16.
//  Copyright © 2016 MustafaSoft. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name:String!
    private var _pokedexId: Int!
    private var _bio:String!
    private var _type:String!
    private var _defance:String!
    private var _height:String!
    private var _wieght:String!
    private var _baseAttack:String!
    private var _nextEvo:String!
    private var _pokemonUrl:String!
    
    
    var name:String {
        return _name
    }
    
    var pokedexId:Int {
        
        return _pokedexId
    }
    
    var type:String {
        
        return _type
    }
    
    init(name:String, pokedexId:Int ){
        
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(url_base)\(url_pokemon)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed:downloadCompleted){
        let url = NSURL(string: _pokemonUrl)
        
        Alamofire.request(.GET, url!).responseJSON { response in
            let result = response.result
            print(result.value.debugDescription)
            
            //convert the json into dictionary
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._wieght = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                    
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defance = "\(defense)"
                }
                
                print(self._wieght)
                print(self._height)
                print(self._baseAttack)
                print(self._defance)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    // grap the first elemnt in the array and grap the first vlaue of the dictionary
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for var i = 1; i > types.count; i++ {
                            if let name = types[i]["name"] {
                                self._type! = self._type + "/\(name.capitalizedString)"
                                
                            }
                            
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                print(self._type)

    
                
            }
        }
        
        
        
     
    }
    
}