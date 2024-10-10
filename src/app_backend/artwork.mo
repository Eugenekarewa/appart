import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Text "mo:base/Text";

module {
  public type ArtworkDetails = {
    id: Nat;
    title: Text;
    creator: Text;
    price: Nat;
    isSold: Bool;
  };

  public type ArtworkModule = {
    init: () -> {
      add: (Text, Text, Nat) -> ();
      list: () -> [ArtworkDetails];
    };
  };

  public let artworkModule: ArtworkModule = {
    init = func() : {
      add: (Text, Text, Nat) -> ();
      list: () -> [ArtworkDetails];
    } {
      var artworkList: [ArtworkDetails] = [];
      return {
        add = func(title: Text, creator: Text, price: Nat) {
          let id = Array.size(artworkList);
          let newArtwork = {
            id = id;
            title = title;
            creator = creator;
            price = price;
            isSold = false;
          };
          artworkList := Array.append(artworkList, [newArtwork]);
        };
        list = func() : [ArtworkDetails] {
          return artworkList;
        };
      };
    };
  };
}