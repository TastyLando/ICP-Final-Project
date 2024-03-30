import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor {
  type Person = {
    id : Nat;
    name : Text;
    city : Text;
    bloodGroup : Text;
    eligibleToDonate : Bool;
    hasContagiousDisease : Bool;
  };

  public type DonaterId = Nat32;
   private stable var next : DonaterId = 0;
  type PersonNeed = {
   id : Nat;
    name : Text;
    city : Text;
    bloodGroup : Text;
  };
  private stable var person : Trie.Trie<DonaterId, PersonNeed> = Trie.empty();
  var personsNeed : [PersonNeed] = [];
  var persons : [Person] = [];

  type DonatedBlood = {
    donorId : Nat;
    bloodGroup : Text;
    amountDonated : Nat;
    //date: Time;
    delivered : Bool;
  };

  var donatedBloods : [DonatedBlood] = [];

  type NeedRequest = {
    requestId : Nat;
    requesterId : Nat;
    bloodGroupNeeded : Text;
    donorId : Nat; // Initially set to none
  };

  var needRequests : [NeedRequest] = [];

public func createDonationRequest(person: Person): async Bool  {
  let ?foundPerson = Array.find(persons, func(p: Person): Bool {
    return p.id == person.id;
  });
  
  if ( foundPerson.hasContagiousDisease) {
    return false; // bulaşıcı hastalığı var
  } else {
    let newRequestId = Array.size(needRequests) + 1;
    return true; // işlem başarılı
  }
    };
  
  public func youNeedBlood(personNeed: PersonNeed): async Bool   {
   
  
  if (personNeed.bloodGroup == "A" or personNeed.bloodGroup == "AB") {
    return true; // Kan grubu A veya AB ise, işlem başarılı
  } else {
    return false; // Diğer durumlarda işlem başarısız
  }
    };

  public func fulfillNeedRequest(requestId : Nat, donorId : Nat) : async Bool {
    if (canFulfillNeedRequest(requestId, donorId)) {
      let needRequest = needRequests[requestId - 1]; // Assuming 1-based indexing
      // needRequest.donorId = donorId;
      
      return true;
    } else {
      return false; // Error handling if request or donor is not valid
    };
  };

  private func canFulfillNeedRequest(requestId : Nat, donorId : Nat) : Bool {
    if (requestId <= 0 or requestId > Array.size(needRequests)) {
      return false; // Request ID out of range
    };  
    if (donorId <= 0 or donorId > Array.size(persons)) {
      return false; // Donor ID out of range
    };
    let needRequest = needRequests[requestId - 1]; // Assuming 1-based indexing
    let donor = persons[donorId - 1]; // Assuming 1-based indexing
    return needRequest.donorId == 0 and donor.bloodGroup == needRequest.bloodGroupNeeded;
  };
};
