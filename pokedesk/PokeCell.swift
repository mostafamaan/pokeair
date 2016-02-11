//
//  PokeCell.swift
//  pokedesk
//
//  Created by Mustafa on 2/11/16.
//  Copyright © 2016 MustafaSoft. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    var pokemon:Pokemon!
    
    // make rounded cell
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon:Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        
        
        
    }
    
    
    
}
