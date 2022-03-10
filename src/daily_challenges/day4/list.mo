import HashMap "mo:base/HashMap";
module {
    public type List<T> = ?(T, List<T>);
    // #7
    public func is_null<T>(l: List<T>) : Bool {
        switch(l) {
            case(null) {
                return true;
            };
            case(?list) {
                return false;
            };
        };
    };

    // #8
    public func last<T>(l : List<T>) : ?T {
        var mut_list = l;
        var lastVal : ?T = null;
        loop {
            switch(mut_list) {
                case(null) {
                    return lastVal;
                };
                case(?(currVal, newList)) {
                    mut_list := newList;
                    lastVal := ?currVal;
                };
            };
        };
    };

    // #9
    public func size<T>(l: List<T>) : Nat {
        var count : Nat = 0;
        var mut_list : List<T> = l;
        label search loop {
            switch(mut_list) {
                case null break search;
                case(?(currVal, newList)) {
                    mut_list := newList; 
                    count += 1;
                }
            };
        };
        count;
    };

    // #10
    public func get<T>(l: List<T>, n: Nat) : ?T {
        var count : Nat = 0;
        var mut_list : List<T> = l;
        loop {
            switch(mut_list) {
                case null return null;
                case(?(currVal, newList)) {
                    if (count == n) {
                        return ?currVal;
                    };
                    mut_list := newList; 
                    count += 1;
                };
            };
        };
    };

    // #11
    public func reverse<T>(l : List<T>) : List<T> {
        
       l; 
    };
}