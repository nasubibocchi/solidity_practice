pragma solidity ^0.8.13;

contract SharedWallet {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    mapping (address => uint) public totalBalance;

    function sendMoney() public payable {
        totalBalance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _from, address payable _to, uint _amount) public {
        require(totalBalance[_from] >= _amount, "Not enough money");
        totalBalance[_from] -= _amount;
        _to.transfer(_amount);
    }

    fallback () external {
        sendMoney();
    }
}
