pragma solidity ^0.5.13;

contract ExceptionExample {
    mapping (address => uint64) public balanceReceived;

    function sendMoney() public payable {
        assert(msg.value == uint64(msg.value));
        balanceReceived[msg.sender] += uint64(msg.value);
        assert(balanceReceived[msg.sender] >= uint64(msg.value));
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not enough ether");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}