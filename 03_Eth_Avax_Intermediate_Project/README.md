**Project Task:-** For this project, you will write a smart contract to create your own ERC20 token and deploy it using HardHat or Remix. Once deployed, you should be able to interact with it for your walk-through video. From your chosen tool, the contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens.

## Introduction To Custom ERC-20 Token

The Solidity smart contract, labeled under the MIT License, is a basic implementation of a token contract called myToken on the Ethereum blockchain. It defines essential attributes of the token, including its name, symbol, decimals, and total supply. The contract enables the owner to mint new tokens, allows token transfers between addresses, and provides a mechanism to burn tokens. Additionally, it implements an approval system for managing token allowances. This contract can serve as a starting point for creating custom tokens and token-based applications on the Ethereum network.

## Code 

```solidity
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract CustomERC20 is ERC20 {
    using SafeMath for uint256;

    address public owner;

    constructor() ERC20("MetacraftersERC", "CRED") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function transferTokens(address receiver, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _transfer(msg.sender, receiver, amount);
    }

    function burn(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _burn(msg.sender, amount);
    }
}
```

- Solidity code defines a custom ERC-20 token contract, CustomERC20, that inherits from OpenZeppelin's ERC20 implementation and uses the SafeMath library to prevent arithmetic vulnerabilities. Let's delve into each component in more detail.

- The SPDX-License-Identifier specifies that the code is released into the public domain without any restrictions (Unlicense). This means users are free to use, modify, and distribute the code without the need for attribution or adherence to any licensing terms.

- The pragma directive specifies the Solidity compiler version compatibility. In this case, the code is designed to work with Solidity version 0.8.0 or any later version.

- Two external contracts are imported from the OpenZeppelin library. The first import brings in the ERC20 contract, which provides a standard interface for fungible tokens. The second import includes the SafeMath library, crucial for preventing arithmetic overflow and underflow vulnerabilities when dealing with unsigned integers.

- The CustomERC20 contract is declared, inheriting from the ERC20 contract and using SafeMath for uint256 operations. It introduces a public address variable owner, indicating the entity that initially deployed the contract.

- The constructor initializes the ERC20 token with the name "MetacraftersERC" and the symbol "CRED." Additionally, it sets the owner variable to the address of the contract deployer. This establishes the owner's identity at the contract's deployment.

- The onlyOwner modifier is defined, restricting certain functions to be executable only by the contract owner. This access control mechanism enhances security by limiting specific operations to authorized users.

- The mint function allows the owner to create new tokens and assign them to a specified address. The transferTokens function facilitates the transfer of tokens from the caller's address to another specified address, provided the caller has a sufficient token balance.

- The burn function enables the caller to destroy a specified amount of their own tokens, assuming they have a balance greater than or equal to the burn amount. This function can be useful for token holders who wish to reduce their token supply.

- Overall, the contract combines standard ERC-20 functionality with additional features such as minting, transferring, and burning. Access control is enforced through the onlyOwner modifier, and the use of SafeMath enhances the contract's security by preventing common arithmetic vulnerabilities.

## Usage

This contract can serve as a foundation for building more complex token-based applications on the Ethereum network. Developers can customize it to define their token's name, symbol, supply, and functionality.

Please note that this contract is provided as a basic example and may require additional features and security measures for production use.

