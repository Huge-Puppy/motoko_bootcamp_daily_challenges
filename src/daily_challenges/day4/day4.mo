import List "mo:base/List";

import Animal "animal";
import Prob1 "custom";
import MyList "list";

actor {
    // #1
    public query func fun() : async Prob1.Prob1 {
        {
            message = "hello world";
            error = "no error";
        };
    };

    // #2
    var animal : Animal.Animal = {species="";energy=0;};

    // #4
    public query func create_animal_then_takes_a_break(s: Text, e: Nat) : async Animal.Animal {
        var newAnimal : Animal.Animal = {
            species = s;
            energy = e;
        };
        Animal.animal_sleep(newAnimal);
    };

    // #5
    var animals : List.List<Animal.Animal> = List.nil<Animal.Animal>();

    // #6
    public func push_animal(a: Animal.Animal) : () {
        animals := List.append<Animal.Animal>(animals, List.make<Animal.Animal>(a));
    };

    public query func get_animals() : async [Animal.Animal] {
        List.toArray<Animal.Animal>(animals);
    };

}