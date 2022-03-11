import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

import HTTP "http";

actor {
    // #1
    type TokenIndex = Nat;
    type Error = {
        #GenericError;
        #AuthError;
    };

    // #2
    stable var registryEntry : [(TokenIndex, Principal)] = [];
    let registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.fromIter<TokenIndex, Principal>(registryEntry.vals(), 0, Nat.equal, Hash.hash);

    // #3
    var nextTokenIndex : Nat = 0;
    public shared({ caller }) func mint() : async Result.Result<(), Error> {
        if (caller == Principal.fromText("2vxsx-fae")) return #err(#AuthError);
        registry.put(nextTokenIndex, caller);
        nextTokenIndex += 1;
        lastMinter := caller;
        return #ok;
    };

    // #4
    public shared({ caller }) func transfer(to: Principal, tokenIndex: Nat) : async Result.Result<(), Error> {
        let owner: ?Principal = registry.get(tokenIndex);
        switch(owner) {
            case(null) return #err(#AuthError);
            case(?principal) {
                if (principal != caller) return #err(#AuthError);
            };
        };
        // transfer the token
        registry.put(tokenIndex, to);
        // update the balances
        #ok;
    };

    // #5
    public shared({ caller }) func balance() : async [TokenIndex] {
        Iter.toArray(HashMap.mapFilter<TokenIndex, Principal, Principal>(
            registry, 
            Nat.equal, 
            Hash.hash, 
            func(key : TokenIndex, val : Principal) {
                if(val == caller) {
                    return ?val;
                };
                return null;
                }).keys());
    };

    var lastMinter : Principal = Principal.fromText("2vxsx-fae");

    // #6
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        let response = {
           body = Text.encodeUtf8("last minter: " # Principal.toText(lastMinter) # "\n# minted: " # Nat.toText(nextTokenIndex));
           headers = [("Content-Type", "text/html; charset=UTF-8")];
           status_code = 200 : Nat16;
           streaming_strategy = null;
        };
        response;
    };

    // #7
    system func preupgrade() {
        registryEntry := Iter.toArray<(TokenIndex, Principal)>(registry.entries());
    };

    system func postupgrade() {
        registryEntry := [];
    };

    // #8
    
};