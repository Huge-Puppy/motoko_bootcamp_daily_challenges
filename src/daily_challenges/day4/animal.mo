module {
    // #2
    public type Animal = {
        species: Text;
        energy : Nat;
    };

    // #3
    public func animal_sleep(a: Animal) : Animal {
        {species= a.species; energy = a.energy + 10};
    };
}