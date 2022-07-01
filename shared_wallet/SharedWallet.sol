pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "./Allowance.sol";

contract SharedWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    // to be not able to renounce ownership by overriding this function
    function renounceOwnership() public view onlyOwner override {
        revert("You can not renounce ownership here");
    }

    // work with v.0.8 
    fallback() external payable {
        // following process is not necessary because fallback() function play the role
        // sendMoney();
        emit MoneyReceived(msg.sender, msg.value);
    }

    // work with v.0.5
    // function () external payable {}
}
