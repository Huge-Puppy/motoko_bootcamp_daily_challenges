import Array "mo:base/Array";
import Nat "mo:base/Nat";

actor {
    // #1
    func _swap<T>(a : [T], j: Nat, i: Nat ) : [T] {
        let b : [var T] = Array.thaw<T>(a);
        let temp : T = b[j];
        b[j] := b[i];
        b[i] := temp;
        Array.freeze<T>(b);
    };

    // #2
    public query func init_count(n: Nat) : async [Nat] {
        Array.tabulate<Nat>(n, func(i: Nat) {return i})
    };

    // #3
    public query func seven(a: [Nat]) : async Text {
        let hasSeven : ?Nat = Array.find<Nat>(a, func(val: Nat) {return val == 8});
        switch(hasSeven) {
            case(null) {
                return "Seven not found";
            };
            case(?val){
                return "Seven is found";
            };
        };
    };

    // #4
    public query func nat_opt_to_nat(n: ?Nat, m: Nat) : async Nat {
        switch(n) {
            case(null) {
                return m;
            };
            case(?val){
                return val;
            };
        };
    };

    // #5
    public query func day_of_the_week(n: Nat) : async ?Text {
        switch(n) {
            case 1 ?"Monday";
            case 2 ?"Tuesday";
            case 3 ?"Wednesday";
            case 4 ?"Thursday";
            case 5 ?"Friday";
            case 6 ?"Saturday";
            case 7 ?"Sunday";
            case other null;
        }
    };

    // #6
    public query func populate_array(a: [?Nat]) : async [Nat] {
        Array.map<?Nat, Nat>(
            a, 
            func(val: ?Nat) {
                switch(val) {
                    case null 0; 
                    case (?nat) nat;
                }
            });
    };

    // #7
    public query func sum_of_array(a: [Nat]) : async Nat {
        Array.foldLeft<Nat, Nat>(a, 0, func(n: Nat, m: Nat) {n+m});
    };

    // #8
    public query func squared_array(a: [Nat]) : async [Nat] {
        Array.map<Nat, Nat>(a, func(val: Nat){val**2});
    };
    
    // #9
    public query func increase_by_index(a: [Nat]) : async [Nat] {
        Array.mapEntries<Nat, Nat>(a, func(val: Nat, i: Nat){val+i});
    };

    // #10
    func contains<A>(array: [A], a: A, f: (A, A) -> Bool) : async Bool {
        switch(Array.find<A>(array, func(val: A){f(val, a)})) {
            case null false;
            case (?_) true;
        }
    };
}