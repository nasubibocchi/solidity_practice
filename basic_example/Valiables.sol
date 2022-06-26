pragma solidity ^0.5.13;

contract WorkingWithVariables {
    uint256 public myUint;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;

    function setMyBoolean(bool _myBool) public {
        myBool = _myBool;
    }

    uint8 public myUint8;

    function incrementMyUint8() public {
        myUint8++;
    }

    function decrementMyUint8() public {
        myUint8--;
    }

    address public myAddress;

    function setMyAddress(address _address) public {
        myAddress = _address;
    }

    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }

    string public myString = "Hello World!";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}