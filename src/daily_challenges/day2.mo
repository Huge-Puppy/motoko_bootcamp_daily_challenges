import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

actor {
    // #1
    public query func nat_to_nat8(a : Nat) : async Nat8 {
        Nat8.fromNat(Nat.max(255, a));
    };

    // #2
    public query func max_number_with_n_bits(a : Nat) : async Nat {
        2 ** a;
    };

    // #3
    public query func decimal_to_bits(a : Nat) : async Text {
        var binary : Text = "";
        var mutableNat : Nat = a;
        while (mutableNat > 0) {
            binary := Nat.toText(mutableNat%2) # binary;
            mutableNat /= 2;
        };
        binary;
    };

    // #4
    public query func capitalize_character(a : Char) : async Char {
        Char.fromNat32(Char.toNat32(a) + 32);
    };

    // #5 
    public query func capitalize_text(a : Text) : async Text {
        var capText : Text = "";
        for (c in a.chars()) {
            if (Char.isUppercase(c)) {
                capText #= Char.toText(c);
            } else {
                capText #= Char.toText(Char.fromNat32(Char.toNat32(c) + 32));
            };
        };
        capText;
    };

    // #6
    public query func is_inside(a: Text, b: Char) : async Bool {
        for (c in a.chars()) {
            if (b == c) {
                return true;
            };
        };
        return false;
    };

    // #7
    public query func trim_whitespace(a: Text) : async Text {
        Text.trim(a, #char ' ');
    };

    // #8
    public query func duplicated_character(a: Text) : async Bool {
        let textArray : [Char] = Iter.toArray(Text.toIter(a));
        for (i in Iter.range(0, textArray.size()-2)) {
            for (j in Iter.range(i+1, textArray.size()-1)) {
                if (textArray[i] == textArray[j]) {
                    return true;
                };
            };
        };
        return false;
    };

    // #9
    public query func size_in_bytes(a: Text) : async Nat {
        var b : Blob = Text.encodeUtf8(a);
        Blob.toArray(b).size();
    };

    // #10
    public query func bubble_sort(a: [Nat]) : async [Nat] {
        var mutableArray : [var Nat] = Array.thaw(a);
        for (i in Iter.range(0, mutableArray.size()-2)) {
            for (j in Iter.range(0, mutableArray.size()-2-i)) {
                if (mutableArray[j] > mutableArray[j+1]) {
                    var temp : Nat = mutableArray[j];
                    mutableArray[j] := mutableArray[j+1];
                    mutableArray[j+1] := temp;
                };
            };
        };
        Array.freeze(mutableArray);
    };

};