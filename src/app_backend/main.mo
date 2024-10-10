import artwork "artwork";
import transaction "transaction";
import user "user";

actor {
  stable var artworks = Artwork.init();   
  stable var users = User.init();         

  query func listArtworks() : async [Artwork.ArtworkDetails] {
    return artworks.list();
  };

  func createArtwork(title: Text, creator: Text, price: Nat) {
    artworks.add(title, creator, price);
  };

  func buyArtwork(artworkId: Nat, buyer: Text) {
    let user = User.getUser(buyer);
    Transaction.buy(artworkId, user, artworks);
  };
}
