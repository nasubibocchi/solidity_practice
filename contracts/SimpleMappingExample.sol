pragma solidity ^0.5.13;

contract SimpleMappingExample {
    // mapping(key type => value type) propertyName;
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setMyMapping(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressMapping() public {
        myAddressMapping[msg.sender] = true;
    }
}