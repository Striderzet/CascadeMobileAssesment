//
//  SetPokemon.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - View Model for the info that the found Pokemon need populated

import Foundation
import Combine
import UIKit

class CurrentPokemon: ObservableObject {
    
    init() { }
    
    @Published var details = Pokemon(name: "", baseExperience: 0) //probably don't need this

    ///This method is needed to set details whenever needed.
    func setDetails(pokemon: Pokemon) {
        //this operation needs to be done on the main thread
        performUIUpdatesOnMain {
            self.details = pokemon
        }
    }
    
    ///Returns calculated price for this Pokemon.
    func price() -> Double {
        return (Double(self.details.baseExperience) * 0.01) * 6
    }
    
}
