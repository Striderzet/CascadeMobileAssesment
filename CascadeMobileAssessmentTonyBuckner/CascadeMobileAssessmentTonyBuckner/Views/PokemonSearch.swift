//
//  ContentView.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - Main app view to enter searches for Pokemon.

import SwiftUI

struct PokemonSearch: View {
    
    //Observed objects
    @ObservedObject var currentPokemon = CurrentPokemon()
    @ObservedObject var currentUser = CurrentUser()
    
    //Present view flag
    @State private var presentViewer = false
    
    //Alert flag
    @State var triggerAlert = false
    
    //search query string
    @State private var searchQuery = String()
    
    //Home screen image
    @State var homeImage: UIImage = UIImage()
    
    //Flag for loading view
    @State private var loadingFlag = false
    
    var body: some View {
        
        ZStack {
            
            NavigationView {
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Image(uiImage: homeImage)
                        .scaleEffect(5.0)
                        .padding()
                    
                    Spacer()
                    
                    Text("Please tell us the Pokemon you want to find!")
                        .padding()
                    TextField("Pokemon Name ie: Pikachu", text: $searchQuery)
                        .padding()
                    
                    Button(action: {
                        
                        //let user know app is working
                        loadingFlag.toggle()
                        
                        getPokemonByName(pokemonName: searchQuery) { found, pokemon, errorMessage in
                            
                            print(errorMessage)
                            
                            if found {
                                //set pulled info to current Pokemon and present view if Pokemon is found
                                currentPokemon.setDetails(pokemon: pokemon)
                                self.loadingFlag.toggle()
                                self.presentViewer.toggle()
                                
                            } else {
                                //prompt an alert if there is an issue
                                triggerAlert.toggle()
                            }
                        }
                    }, label: {
                        
                        Text("GO!")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    })
                    .sheet(isPresented: $presentViewer, content: {
                        PokemonViewer(currentPokemon: currentPokemon, currentUser: currentUser)
                    })
                    .disabled(searchQuery.isEmpty)
                    .background(Color(.systemRed))
                    .cornerRadius(5.0)
                    .alert(isPresented: $triggerAlert, content: {
                        
                        //in a larger app, this alert would need to be more detailed with multiple API calls
                        Alert(title: Text("Error"), message: Text("Either this Pokemon does not exist or there is a internet issue. Please try again."), dismissButton: .default(Text("OK")){ self.loadingFlag.toggle() })
                        
                    })
                    
                    Spacer()
                    
                    
                }
                .onAppear(perform: {
                    //Image for home screen (Poke-ball). The URL is straightforward.
                    getFoundPokemonImage(imageString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png") {good, image in
                        if good {
                            homeImage = image
                        }
                    }
                })
                
                
                .navigationBarTitle(Text("Pokemon Shop"))
                .navigationBarItems(
                    leading: Text("\(self.currentUser.details.firstName) \(self.currentUser.details.lastName)"),
                    trailing: Text("Balance: \(truncateZeros(self.currentUser.details.balance))"))
                
                
            }
            
            //Show loading screen
            if loadingFlag {
                LoadingView()
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSearch()
    }
}
