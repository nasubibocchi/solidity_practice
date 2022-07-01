pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    // 'owner' is defined in Ownable 
    // address payable owner;

    // constructor() {
    //     owner = payable(msg.sender);
    // }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "You are not allowed");
    //     _;
    // }

    // create isOwner() because Ownable.sol does not define this function(?)
    function isOwner() public view returns(bool) {
        return msg.sender == owner();
    }

    // mapping (address => uint) public totalBalance;

    // function sendMoney() public payable {
    //     totalBalance[msg.sender] += msg.value;
    // }

    mapping(address => uint) public allowance;

    // add allowance to withdraw money(amount) by owner
    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        // require(totalBalance[msg.sender] >= _amount, "Not enough money");
        // totalBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // work with v.0.8.13 
    fallback() external payable {
        // following process is not necessary because fallback() function play the role
        // sendMoney();
    }

    // work with v.0.5.13 
    // function () external payable {}
}
