pragma solidity ^0.5.13;

contract MappingStructExample {
    struct Payment {
        uint amount;
        uint timestamps;
    }

    struct Balance {
        uint totalBalance;
        uint numPayment; // number of times payment
        mapping (uint => Payment) payments; 
    }

    mapping (address => Balance) public balanceRecieved;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceRecieved[msg.sender].totalBalance += msg.value;

        Payment memory payment = Payment(msg.value, now);

        // define payments as property of Balance
        balanceRecieved[msg.sender].payments[balanceRecieved[msg.sender].numPayment] = payment;
        // define numPayment as property of Balance
        balanceRecieved[msg.sender].numPayment++;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceRecieved[msg.sender].totalBalance >= _amount, "Not enough funds");
        balanceRecieved[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount); 
    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceRecieved[msg.sender].totalBalance;
        balanceRecieved[msg.sender].totalBalance = 0; 
        _to.transfer(balanceToSend);
    }
}