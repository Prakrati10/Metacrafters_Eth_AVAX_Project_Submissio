**Project Task:-** For this project, you will write a smart contract to create your own ERC20 token and deploy it using HardHat or Remix. Once deployed, you should be able to interact with it for your walk-through video. From your chosen tool, the contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens.

## Introduction To Custom ERC-20 Token

The Solidity smart contract, labeled under the MIT License, is a basic implementation of a token contract called myToken on the Ethereum blockchain. It defines essential attributes of the token, including its name, symbol, decimals, and total supply. The contract enables the owner to mint new tokens, allows token transfers between addresses, and provides a mechanism to burn tokens. Additionally, it implements an approval system for managing token allowances. This contract can serve as a starting point for creating custom tokens and token-based applications on the Ethereum network.

## Code 

```solidity
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
```
The myToken smart contract is a basic implementation of a token contract on the Ethereum blockchain. It serves as a starting point for creating custom tokens and token-based applications. Let's break down its components, functions, and key concepts:

**Contract Attributes**

**owner:** This address variable stores the Ethereum address of the contract owner.

**TokenName and Tokensymbol:** These string variables represent the name and symbol of the token, respectively.

**TokenDecimals:** An unsigned integer variable specifying the number of decimal places for token balances.

TokenTotalSupply: An unsigned integer variable representing the total supply of tokens. It is initially set to 0.

**Functions**

**mintTokens(address to, uint256 amount)**
This function allows the contract owner to create (mint) new tokens.

**Parameters:**

to: The recipient's address.
amount: The amount of tokens to mint.
It increases the TokenTotalSupply by the specified amount and adds the minted tokens to the balance of the recipient's address.

**transferTokens(address receiver, uint256 amount)**

This function enables token transfers between addresses.

Parameters:

receiver: The recipient's address.

amount: The amount of tokens to transfer.
It verifies that the sender has a balance greater than or equal to the transfer amount and then proceeds to transfer tokens from the sender to the receiver.

**burnToken(uint256 amount)**

This function allows token holders to destroy (burn) their tokens.

**Parameters:**

amount: The amount of tokens to burn.
It checks if the sender has a balance greater than or equal to the burn amount and then reduces the TokenTotalSupply and subtracts the burned tokens from the sender's balance.

## Usage

This contract can serve as a foundation for building more complex token-based applications on the Ethereum network. Developers can customize it to define their token's name, symbol, supply, and functionality.

Please note that this contract is provided as a basic example and may require additional features and security measures for production use.

