pragma solidity ^0.8.13;

contract SharedWallet {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    mapping (address => uint) public totalBalance;

    function sendMoney() public payable {
        totalBalance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        require(totalBalance[msg.sender] >= _amount, "Not enough money");
        totalBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    fallback () external {
        sendMoney();
    }
}
