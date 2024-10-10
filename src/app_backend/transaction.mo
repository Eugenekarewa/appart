import User "user";
import Artwork "artwork";

module Transaction {
  public func buy(artworkId: Nat, buyer: User.UserProfile, artworkModule: { init : () -> { add : (Text, Text, Nat) -> (); list : () -> [Artwork.ArtworkDetails]; updateArtwork : (Artwork.ArtworkDetails) -> () } }) : (User .UserProfile, Artwork.ArtworkDetails) {
    let initResult = artworkModule.init();
    let artworks : [Artwork.ArtworkDetails] = initResult.list();
    let selectedArtworks : [Artwork.ArtworkDetails] = Array.filter(artworks, func (artwork) { artwork.id == artworkId });

    // Explicitly specify the type of the variable
    let artworkPrice : Nat = selectedArtworks[0].price;

    if (selectedArtworks.size > 0 and artworkPrice <= buyer.walletBalance) {
      // Perform the transaction logic
      // Update the sold status by creating a new instance
      let updatedArtwork : Artwork.ArtworkDetails = {
        id = selectedArtworks[0].id;
        title = selectedArtworks[0].title;
        creator = selectedArtworks[0].creator;
        price = selectedArtworks[0].price;
        isSold = true; // Mark the artwork as sold
      };

      // Update artwork in the artwork list
      artworkModule.updateArtwork(updatedArtwork);
      
      // Update the buyer's wallet balance
      let updatedBuyer : User.UserProfile = {
        name = buyer.name;
        walletBalance = buyer.walletBalance - artworkPrice;
      };

      return (updatedBuyer, updatedArtwork);
    } else {
      // Handle errors like insufficient balance or artwork not found
      // For instance, you could log an error or throw an exception
      Debug.trap("Insufficient balance or artwork not found");
    }
  }
}