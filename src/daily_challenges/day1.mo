import Array "mo:base/Array";
import Iter "mo:base/Iter";

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
      Array.filter<Nat>(a, func(x : Nat) {x != b});
    };

    public query func selection_sort(a: [Nat]) : async [Nat] {
      if (a.size() == 0) {
        return [];
      };
      var tempArray : [var Nat] = Array.thaw(a);
      var currentIndex : Nat = tempArray[0];
      var minIndex : Nat = tempArray[0];
      for (i in Iter.range(0, tempArray.size()-1)) {
        minIndex := i;
        currentIndex := i;
        for (j in Iter.range(i, tempArray.size()-1)) {
          if (tempArray[j] < tempArray[minIndex]) {
            minIndex := j;
          };
        };
        var tempVal : Nat = tempArray[currentIndex];
        tempArray[currentIndex] := tempArray[minIndex];
        tempArray[minIndex] := tempVal;
      };
      Array.freeze(tempArray);
    };
};
