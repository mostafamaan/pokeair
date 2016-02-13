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
    private var _nextEvoId:String!
    private var _pokemonUrl:String!
    private var _nextEvoLevel:String!
    
    var bio:String {
        get {
            if _bio == nil {
                _bio = ""
            }
            return _bio

        }
        
           }
    
    var defense:String{
        
        if _defance == nil {
            _defance = ""
        }
        
        return _defance
    }
    
    var height:String {
        
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var wieght:String{
        if _wieght == nil {
            _wieght = ""
        }
        return _wieght
    }
    
    var attack:String{
        
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    var nextEvo:String{
        
        if _nextEvo == nil {
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    var nextEvoId:String{
        
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        
        return _nextEvoId
    }
    
    var nextEvoLevel:String{
        
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    
    var name:String {
        return _name
    }
    
    var pokedexId:Int {
        
        return _pokedexId
    }
    
    var type:String {
        
        if _type == nil {
            _type = ""
        }
        
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
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        // mega is not find problem with the api
                        if to.rangeOfString("mega") == nil {
                            if let evoUrl = evolutions[0]["resource_uri"] as? String {
                                let newString = evoUrl.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let evoId = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvoId = evoId
                                self._nextEvo = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvoLevel = "\(lvl)"
                                }
                                
                            
                            }
                            
                        }
                    }
                }
                
                print(self._type)
                print(self._nextEvoId)
                print(self._nextEvoLevel)
                print(self._nextEvo)
                
                if let disArray = dict["descriptions"] as? [Dictionary<String,String>] where disArray.count > 0 {
                    
                    if let urlString = disArray[0]["resource_uri"]
                    {
                        let url = NSURL(string: "\(url_base)\(urlString)")
                        
                        Alamofire.request(.GET, url!).responseJSON { response in
                            let result = response.result
                            if let disDict = result.value as? Dictionary<String,AnyObject>{
                                
                                if let bio = disDict["description"] as? String {
                                    self._bio = bio
                                    print(self._bio)
                                }
                            }
                            
                            completed()
                        }
                        
                    }
                    else {
                        self._bio = ""
                    }
                    
                }
                
            }
        }
        
        
        
        
    }
    
}