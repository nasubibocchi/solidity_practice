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
