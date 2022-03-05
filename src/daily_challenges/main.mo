import L "mo:base/List";

actor {
    public query func add(a: Nat, b: Nat) : async Nat {
        a + b;
    };

    public query func square(a: Nat) : async Nat {
        a ** 2;
    };

    public query func days_to_second(a: Nat) : async Nat {
        a * 86400;
    };

    private var counter : Nat = 0;
    public func increment_counter() : async Nat {
        counter += 1;
        counter;
    };

    public func clear_counter() : async () {
        counter := 0;
    };

    public query func divide(a: Nat, b: Nat) : async Bool {
      if (a % b == 0) {
        return true;
      };
      false;
    };

    public query func is_even(a: Nat) : async Bool {
      a % 2 == 0;
    };

    public query func sum_of_array(a: [Nat]) : async Nat {
      var sum : Nat = 0;
      for (num in a.vals()) {
        sum += num;
      };
      sum;
    };

    public query func maximum(a: [Nat]) : async Nat {
      var max : Nat = 0;
      for (num in a.vals()) {
        if (num > max) {
          max := num;
        };
      };
      max;
    };

    public query func remove_from_array(a: [Nat], b: Nat) : async [Nat] {
      [0];
    }
};
