//
//  ViewPokemon.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - View that will be presented when a Pokemon is found

import SwiftUI

struct PokemonViewer: View {
    
    //State objects inherited from observed.
    @StateObject var currentPokemon: CurrentPokemon
    @StateObject var currentUser: CurrentUser
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                
                //Pokemon image
                Spacer()
                Image(uiImage: self.currentPokemon.details.image)
                    .scaleEffect(3.0)
                    .padding()
                
                //Pokemon name
                Text("Name: \(self.currentPokemon.details.name.capitalized)")
                    .padding()
                
                //Price as calculated
                Text("Price: \(truncateZeros(self.currentPokemon.price()))") //"Price: \(truncateZeros(self.currentPokemon.price()))"
                    .padding()
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    
                    //Check balance against price. In a lager app, this would be created as an object that would return a view, in this case "Text".
                    if balanceCheck(userBalance: self.currentUser.details.balance, pokemonPrice: self.currentPokemon.price()) {
                        
                        Text("Purchase")
                            .foregroundColor(.white)
                            .frame(width: 175, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    } else {
                        
                        Text("Not enough funds")
                            .foregroundColor(.white)
                            .frame(width: 175, height: 30, alignment: .center
                            )
                    }
                    
                })
                .background(Color(.systemBlue))
                .cornerRadius(5.0)
                
                Spacer()
                
            }
            
            
            .navigationBarTitle(Text(self.currentPokemon.details.name.capitalized))
            .navigationBarItems(
                leading: Text("\(self.currentUser.details.firstName) \(self.currentUser.details.lastName)"),
                trailing: Text("Balance: \(truncateZeros(self.currentUser.details.balance))"))
            
            
        }
    }
}

struct ViewPokemon_Previews: PreviewProvider {
    static var previews: some View {
        let currentPokemon = CurrentPokemon()
        let currentUser = CurrentUser()
        PokemonViewer(currentPokemon: currentPokemon, currentUser: currentUser)
    }
}
