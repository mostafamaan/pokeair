//
//  DetailViewController.swift
//  pokedesk
//
//  Created by Mustafa on 2/12/16.
//  Copyright © 2016 MustafaSoft. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defanceLabel: UILabel!
    @IBOutlet weak var hieght: UILabel!
    @IBOutlet weak var wieght: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    
    
    
    
    
    
    var pokemon:Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        
        
       navigationController?.navigationBar.topItem?.title = pokemon.name
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokeIDLabel.text = "\(pokemon.pokedexId)"
         


        pokemon.downloadPokemonDetails { () -> () in
          //  this will call when the download is done
            
            self.typeLabel.text = self.pokemon.type
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    
    
    
    @IBAction func doneBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
