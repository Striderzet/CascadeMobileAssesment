//
//  PokeAPI.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
// MARK: This method simply calls the API by searched Pokemon name. WIll return a false value if that Pokemon does not exist.

import Foundation
import UIKit
import Combine
import SwiftUI

///Get Pokemon by entering the name. This is more of a direct text matching rather than a search, so if the text does not match, we will get a false return value. Otherwise, if the name of the requested Pokemon is correct, you will get a result as long as there is an internet connection.
func getPokemonByName(pokemonName: String, pokemonFound: @escaping( _ good: Bool, _ returnPokemon: Pokemon, _ errorMessage: String) -> Void) {
    
    //We are using a direct string here because this is a simple API call. For multiple API calls with multiple keys and values, we would use the method parameter and URL component approach. Also, no need to set JSON header, for this call is always GET.
    let pokeAPIURL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonName.lowercased())/")
    
    //set found Pokemon for error return and data return
    var foundPokemon = Pokemon()
    
    let task = URLSession.shared.dataTask(with: pokeAPIURL!) { data, response, error in
        
        //Error handling and response
        func displayError(_ error: String) {
            print(error)
        }
        guard (error == nil) else {
            pokemonFound(false, foundPokemon, "There was an error with your request: \(String(describing: error))")
            return
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            pokemonFound(false, foundPokemon, "Your request returned a status code other than 2xx!")
            return
        }
        guard let data = data else {
            pokemonFound(false, foundPokemon, "The Pokemon you are searching for does not exist")
            return
        }
        //End error checking
        
        //Parse JSON Data
        var parsedResult = [String:AnyObject]()
        
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
        } catch {
            displayError("Could not parse the data as JSON: '\(String(describing: data))'")
            pokemonFound(false, foundPokemon, "Corrupt Data")
            return
        }
        
        //set the found Pokemon and return it with an image to go with it.
        getFoundPokemonImage(imageString: parsedResult["sprites"]?["front_default"] as? String ?? "") { good, pokemonImage in
            
            if good {
                
                foundPokemon = Pokemon(name: parsedResult["name"] as? String ?? "",
                                           baseExperience: parsedResult["base_experience"] as? Int ?? 0,
                                           image: pokemonImage)
                
                pokemonFound(true, foundPokemon, "The Pokemon you have requested is found")
                
            }
            
        }
        
        
        
    }
    task.resume()
}

///This call will get the image of the found Pokemon from the URL string. This API call is similar to the other call as far as error checking but wont return anything for those errors, just leave the image nil.
func getFoundPokemonImage(imageString: String, _ returnImage: @escaping(_ good: Bool, _ pokemonImage: UIImage) -> Void) {
    
    //The Url String may be empty accidentally.
    guard let _ = URL(string: imageString) else {
        return
    }
    
    let imageURL = URL(string: imageString)
    let task = URLSession.shared.dataTask(with: imageURL!) { data, response, error in
        func displayError(_ error: String) {
            print(error)
        }
        guard (error == nil) else {
            displayError("There was an error with your request: \(String(describing: error))")
            return
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            displayError("Your request returned a status code other than 2xx!")
            return
        }
        guard let data = data else {
            displayError("No data was returned by the request!")
            return
        }
        if error == nil {
            let downloadImage = UIImage(data: data)
            if downloadImage != nil{
                returnImage(true, downloadImage!)
            }
        }
    }
    task.resume()
}


