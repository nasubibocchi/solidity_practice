pragma solidity ^0.8.13;

library Search {
    function indexOf(uint[] storage self, uint value) public view returns(uint) {
        for (uint i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return i;
            } else {
                return uint(self.length);
            }
        }
    }
}

contract UsingSearchLibraryExample {
    using Search for uint[];
    uint[] public data;
    
    function append(uint _value) public {
        data.push(_value);
    }

    function replace(uint _old, uint _new) public {
        uint _oldIndex = data.indexOf(_old);
        // 'data' is supplied as first argument of 'indexOf()'

        if (_oldIndex == uint(data.length)) {
            data.push(_new);
        } else {
            data[_oldIndex] = _new;
        }
    }
}