import Nat "mo:base/Nat";

module {
  /// Represents a user profile with a name and wallet balance.
  public type UserProfile = {
    name: Text;
    walletBalance: Nat;
  };

  /// Adds a new user with a default wallet balance of 1000.
  public func addUser(name: Text) : () {
    if (name == "") {
      // Handle empty name error
      // You could throw an exception or return an error value
    };
    // Create a new UserProfile instance, but don't return it
    let _ = { name = name; walletBalance = 1000 };
  };

  /// Initializes the user module with an addUser function.
  public func init() : { 
    addUser: (Text) -> ()
  } {
    return { 
      addUser
    };
  }
}