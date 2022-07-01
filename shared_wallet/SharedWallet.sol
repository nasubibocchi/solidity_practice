pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint;

    event ChangeAllowance(address indexed _forWho, address indexed _whom, uint _oldAmount, uint _newAmount);

    // create isOwner() because Ownable.sol does not define this function(?)
    function isOwner() public view returns(bool) {
        return msg.sender == owner();
    }

    mapping(address => uint) public allowance;

    // add allowance to withdraw money(amount) by owner
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit ChangeAllowance(_who, msg.sender, allowance[_who], allowance[_who].add(_amount));
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal {
        emit ChangeAllowance(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
}

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
