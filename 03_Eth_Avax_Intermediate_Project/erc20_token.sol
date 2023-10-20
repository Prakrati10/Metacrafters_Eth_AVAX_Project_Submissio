// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract myToken {

    address public owner;
    string public TokenName;
    string public TokenAbbre;
    uint8 public TokenDecimals;
    uint256 public TokenTotalSupply;

    constructor() {
        owner = msg.sender;
        TokenName = "MetacraftersERC";
        TokenAbbre = "CRED";
        TokenDecimals = 10;
        TokenTotalSupply = 0;
    }

    modifier Owner() {
        require( msg.sender == owner, "Only the Admin can use creation tokens.");
        _;
    }

    mapping(address => uint256) public balance;

    function Minting(address to, uint256 amount) public Owner{
        TokenTotalSupply += amount;
        balance[to] += amount;
    }

    function transferTokens(address reciever, uint256 amount) public {
        require( balance[msg.sender] >= amount, "Please choose an amount that is either equal to or less than your current balance." );

        balance[msg.sender] -= amount;
        balance[reciever] += amount;
    }

    function Burning(uint256 amount) public {
        require( balance[msg.sender] >= amount,"Please select an amount that is equal to or less than your current balance.");

        TokenTotalSupply -= amount;
        balance[msg.sender] -= amount;
    }
}
