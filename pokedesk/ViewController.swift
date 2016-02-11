//
//  ViewController.swift
//  pokedesk
//
//  Created by Mustafa on 2/11/16.
//  Copyright © 2016 MustafaSoft. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    
    var filtredPokemon = [Pokemon]()
    
    var musicPlayer = AVAudioPlayer!()
    
    var inSearchMod = false
    
    @IBOutlet weak var collection:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.blueColor()
        parsePokemonCSV()
        initAudio()
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !inSearchMod {
            
        
        return pokemonArray.count
    
        }
        else {
            return filtredPokemon.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collection.dequeueReusableCellWithReuseIdentifier("pokeCell", forIndexPath: indexPath) as? PokeCell
        {
            
            //var pokemon = pokemonArray[indexPath.row]
            
            
            var poke = Pokemon!()
            if inSearchMod {
                poke = filtredPokemon[indexPath.row]
            }
            else {
                poke = pokemonArray[indexPath.row]
                
            }
            cell.configureCell(poke)
            return cell
            
        }
            
        else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemonArray.append(poke)
            }
        }
        catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        
    }
    @IBAction func music(sender: UIBarButtonItem) {
        
        if musicPlayer.playing {
            
            musicPlayer.stop()
            sender.title = "play"
            
        }
        else {
            musicPlayer.play()
            
            sender.title = "pause"
        }
            
        
        
        
    }
    
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError {
            
            print(err.debugDescription)
            
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMod = false
            view.endEditing(true)
            collection.reloadData()
            
        }
        else {
            inSearchMod = true
            
            let lower = searchBar.text!.lowercaseString
            filtredPokemon = pokemonArray.filter({$0.name.rangeOfString(lower) != nil })
            collection.reloadData()
        }
    }
 
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

