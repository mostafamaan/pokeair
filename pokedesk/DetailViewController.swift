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
    
    
    
    
    
    
    var activityIndicatorView: ActivityIndicatorView!
    var pokemon:Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())

        
        navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        
        
       navigationController?.navigationBar.topItem?.title = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        
        pokeIDLabel.text = "\(pokemon.pokedexId)"
        currentEvoImg.image = img
         


        pokemon.downloadPokemonDetails { () -> () in
          //  this will call when the download is done
            self.updateUI()
            
            self.typeLabel.text = self.pokemon.type
            
        }
        
            }
    
    func updateUI() {
        self.activityIndicatorView.startAnimating()
   //     UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        bioLabel.text = pokemon.bio
        typeLabel.text = pokemon.type
        defanceLabel.text = pokemon.defense
        hieght.text = pokemon.height
        wieght.text = pokemon.wieght
        baseAttackLabel.text = pokemon.attack
        
        var string = "Next Evolution: \(pokemon.nextEvo)"
        if pokemon.nextEvoLevel != "" {
            string += " -lvl \(pokemon.nextEvoLevel)"
            evoLabel.text = string
            
        }
        
        if pokemon.nextEvoId == "" {
            evoLabel.text = "There is no Evolution"
            nextEvoImage.hidden = true
        }
        else {
        
        nextEvoImage.image = UIImage(named: pokemon.nextEvoId)
        nextEvoImage.hidden = false
        
        }
        
        self.activityIndicatorView.stopAnimating()
       // UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    
    
    
    @IBAction func doneBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
