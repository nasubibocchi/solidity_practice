pragma solidity ^0.5.13;

contract SendMoneyExample {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    bool isPaused; // it is false if not initialized

    function setIsPaused(bool _isPaused) public {
        require(msg.sender == owner, "You are not the owner");
        isPaused = _isPaused;
    }

    uint public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable to = msg.sender;
        to.transfer(this.getBalance());
    }

    function withdrawMoneyTo(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        require(!isPaused, "The Contract is paused");
        _to.transfer(this.getBalance());
    }
}
