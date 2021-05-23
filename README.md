# CascadeMobileAssesment

This mobile app dev assessment uses the API PokeAPI.co to populate views in the app.

The app is a mini marketplace where the user can search for any Pokemon, as long as it exists in the database, and will throw an error via pop up alert if it does not or there is some network issue. Note, when a Pokemon is not found, the error code thrown back is a network error code, so it can be either one.

For this build, the default user is myself and cannot be modified, although there is code to do so, it is not implemented. The infomation provided is my name, email, "account number", and account balance for purchasing Pokemon. 

The Home view of this app is a pic of a Poke-ball, with a search bar and a search button. Searches will only be executed if the text field is populated.

Once a successful search is done, the user is presented with a view of the found Pokemon, complete with an image of the Pokemon, name, and the price as calculated in the instructions for this assignment. The purchase button text lets the user know if they can purchase the Pokemon if they have sufficient funds, or lets the user know otherwise. This button has no function. Users can exit the view by swiping down, since it is presented modaly.
