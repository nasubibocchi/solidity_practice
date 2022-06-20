pragma solidity ^0.5.13;

contract MappingStructExample {
    mapping (address => uint) public balanceRecieved;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceRecieved[msg.sender] += msg.value;
    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceRecieved[msg.sender];
        balanceRecieved[msg.sender] = 0; 
        _to.transfer(balanceToSend);
    }
}