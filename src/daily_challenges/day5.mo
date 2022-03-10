import Cycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

actor {
    // #1 
    public shared({ caller }) func is_anonymous() : async Bool {
        caller == Principal.fromText("2vxsx-fae");
    };

    // #2
    // let favoriteNumber : HashMap.HashMap<Principal, Nat> = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // #3
    // public shared({ caller }) func add_favorite_number(n: Nat) : () {
        // favoriteNumber.put(caller, n);
    // };

    public shared({ caller }) func show_favorite_number() : async ?Nat {
        favoriteNumber.get(caller);
    };

    // #4
    public shared({ caller }) func add_favorite_number(n: Nat) : async Text {
        switch(favoriteNumber.get(caller)) {
            case null {
                favoriteNumber.put(caller, n);
                return "You've successfully registered your number";
            };
            case (?nat) return "You've already registered your number";
        };
    };

    // #5
    public shared({ caller }) func update_favorite_number(n : Nat) : () {
        favoriteNumber.put(caller, n);
    };

    public shared({ caller }) func delete_favorite_number() : () {
        favoriteNumber.delete(caller);
    };

    // #6
    public func deposit_cycles() : async Nat {
        let available = Cycles.available();
        let accepted = Cycles.accept(available);
        assert(available == accepted);
        accepted;
    };

    // #7
    public shared({ caller }) func withdraw_cycles(n : Nat) : async Nat  {
        Cycles.add(n);
        // TODO: somehow call caller's deposit_cycles function
        n;
    };

    // #8
    private stable var version_number : Nat = 0;
    private stable var counter : Nat = 0;

    public func update(n: Nat) : () {
        counter := n;
    };

    public query func getCount() : async Nat {
        counter;
    };

    system func postupgrade() {
        version_number += 1;
        favoriteNumberState := [];
    };

    // #9
    stable var favoriteNumberState : [(Principal, Nat)] = [];
    let favoriteNumber : HashMap.HashMap<Principal, Nat> = HashMap.fromIter<Principal, Nat>(favoriteNumberState.vals(), 0, Principal.equal, Principal.hash);

    system func preupgrade() {
        favoriteNumberState := Iter.toArray<(Principal, Nat)>(favoriteNumber.entries());
    };
};