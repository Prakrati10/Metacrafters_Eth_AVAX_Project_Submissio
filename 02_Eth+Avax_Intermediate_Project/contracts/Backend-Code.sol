// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {

    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event BalanceMultiplied(uint256 previousBalance, uint256 newBalance);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(uint initBalance) payable {

        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function getCurrentTimestamp() public view returns (uint256) {
        return block.timestamp;
    }
        

    function isOwner(address _address) public view returns (bool) {
        return _address == owner;
    }

    function deposit(uint256 _amount) public payable {

        uint256 _previousBalance = balance;

        require(msg.sender == owner, "The ownership of this account does not belong to you.");

        balance += _amount;

        assert(balance == _previousBalance + _amount);

        emit Deposit(_amount);

    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "The ownership of this account does not belong to you.");

        uint256 _previousBalance = balance;

        if (balance < _withdrawAmount) {
            revert InsufficientBalance({balance: balance, withdrawAmount: _withdrawAmount});
        }

        balance -= _withdrawAmount;

        assert(balance == (_previousBalance - _withdrawAmount));

        emit Withdraw(_withdrawAmount);
    }

    function multiplyBalance(uint256 _multiplier) public {

        require(msg.sender == owner, "The ownership of this account does not belong to you.");

        uint256 _previousBalance = balance;

        balance *= _multiplier;

        assert(balance == _previousBalance * _multiplier);

        emit BalanceMultiplied(_previousBalance, balance);
    }

    function transferOwnership(address payable _newOwner) public {

        require(msg.sender == owner, "The ownership of this account does not belong to you.");

        require(_newOwner != address(0), "The provided address is not valid.");

        address payable _previousOwner = owner;

        owner = _newOwner;

        emit OwnershipTransferred(_previousOwner, _newOwner);
    }
}
