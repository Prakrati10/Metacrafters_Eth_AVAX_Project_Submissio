## Introduction 

The DegenGaming smart contract is a decentralized application (DApp) built on the Ethereum blockchain, designed to facilitate a virtual gaming ecosystem with its native digital asset, Degen Gaming Token (Degen). Utilizing the Solidity programming language and following version ^0.8.18 of the Ethereum Virtual Machine (EVM), this contract introduces a set of functionalities for managing in-game products, player balances, and the issuance and transfer of the Degen token.

Let's delve into the salient features of this contract:


## Code
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DegenGaming {
    address public owner;
    string public gameName = "Degen Gaming";
    string public gameSymbol = "Degen";
    uint8 public gameDecimals = 10;
    uint256 public totalSupply = 0;

    mapping(uint256 => string) public productNames;
    mapping(uint256 => uint256) public productPrices;
    mapping(address => uint256) public playerBalances;
    mapping(address => mapping(uint256 => bool)) public purchasedProducts;
    mapping(address => uint256) public purchasedProductCount;

    event Mint(address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed user, string itemName);

    modifier onlyGameOwner() {
        require(msg.sender == owner, "Only the owner can use this function.");
        _;
    }

    constructor() {
        owner = msg.sender;

        addGameProduct(0, "Game Hoodie", 5);
    }

    function addGameProduct(uint256 itemId, string memory _itemName, uint256 _itemPrice) public onlyGameOwner {
        productNames[itemId] = _itemName;
        productPrices[itemId] = _itemPrice;
    }

    function createGameToken(address to, uint256 amount) external onlyGameOwner {
        totalSupply += amount;
        playerBalances[to] += amount;
        emit Mint(to, amount);
        emit Transfer(address(0), to, amount);
    }

    function gameTokenTransfer(address receiver, uint256 amount) external returns (bool) {
        require(playerBalances[msg.sender] >= amount, "Insufficient balance for the transfer.");
        playerBalances[msg.sender] -= amount;
        playerBalances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function burnGameToken(uint256 amount) external {
        require(amount <= playerBalances[msg.sender], "Insufficient balance for burning.");
        playerBalances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
    }

    function redeemGameItem(uint256 itemId) external returns (string memory) {
        require(productPrices[itemId] > 0, "Invalid item ID for redemption.");
        uint256 redemptionAmount = productPrices[itemId];
        require(playerBalances[msg.sender] >= redemptionAmount, "Insufficient balance to redeem the item.");

        playerBalances[msg.sender] -= redemptionAmount;
        purchasedProducts[msg.sender][itemId] = true;
        purchasedProductCount[msg.sender]++;
        emit Redeem(msg.sender, productNames[itemId]);

        return productNames[itemId];
    }

    function getRedeemedItemCount(address user) external view returns (uint256) {
        return purchasedProductCount[user];
    }
}
```

The contract is named DegenGaming and specifies the version of the Solidity compiler to be used (^0.8.18).
It includes state variables to store information such as the owner's address (owner), the name and symbol of the game token (gameName and gameSymbol), the number of decimals for the token (gameDecimals), and the total token supply (totalSupply).

**Mappings:**

Several mappings are used to associate data with unique identifiers:
productNames: Associates an itemId with the corresponding product name.
productPrices: Associates an itemId with the price of the corresponding product.
playerBalances: Associates player addresses with their Degen token balances.
purchasedProducts: Tracks whether a player has purchased a specific item.
purchasedProductCount: Counts the number of items a player has purchased.

**Events:**

The contract emits events to log important state changes. These include Mint for token creation, Transfer for token transfers, Burn for token burning, and Redeem for item redemptions.

**Modifiers:**

The onlyGameOwner modifier restricts certain functions to be accessible only by the owner of the contract, enhancing security and access control.
Constructor:

The constructor is called when the contract is deployed. It sets the contract owner to the address that deployed it and initializes the contract with an initial game product (a hoodie) using the addGameProduct function.

**Functions:**

addGameProduct: Allows the owner to add new game products by specifying their itemId, name, and price.
createGameToken: Allows the owner to mint new Degen tokens and assign them to a specified address.
gameTokenTransfer: Enables players to transfer Degen tokens to other addresses.
burnGameToken: Allows players to burn a specified amount of their Degen tokens, reducing the total supply.
redeemGameItem: Lets players redeem in-game items by spending Degen tokens.

**Modifiers and Checks:**

The contract uses the onlyGameOwner modifier to restrict certain functions to the contract owner.
Various functions include require statements to check conditions before proceeding, such as ensuring sufficient balances or valid item redemptions.

# Key Features:

**Ownership and Initialization:**

The contract is owned by an Ethereum address, and the owner has exclusive rights over certain privileged functions through the onlyGameOwner modifier.

**Token Details:**

The Degen token is characterized by a name ("Degen Gaming"), symbol ("Degen"), and 10 decimals.
The contract starts with an initial total supply of 0 Degen tokens but allows the owner to mint new tokens and distribute them to players.

**Game Products:**

The contract supports a variety of in-game products, each identified by a unique itemId. Products have associated names and prices, and the owner can add new products through the addGameProduct function.

**Token Minting and Transfers:**

The owner can create Degen tokens and distribute them to players using the createGameToken function.
Players can transfer Degen tokens to other addresses through the gameTokenTransfer function, subject to available balances.

**Token Burning:**

Players can burn their Degen tokens, reducing the total supply. This is done through the burnGameToken function, ensuring that the player has a sufficient balance.

**Product Redemption:
**
Players can redeem in-game items using their Degen tokens, with each item associated with a specific itemId. The redeemGameItem function handles the redemption process, updating player balances and keeping track of redeemed items.

**Events:**

The contract emits events such as Mint, Transfer, Burn, and Redeem to provide transparency and allow external systems to listen for and react to specific activities within the contract.


## Getting Started With Remix
```solidity
To execute this program and interact with the "DegenGaming" smart contract on the Avalanche Fuji Testnet, follow these steps:

Ensure Connection to Avalanche Fuji Testnet:

Make sure your metamask are connected to the Avalanche Fuji Testnet using your MetaMask wallet, and you have some test AVAX (Avalanche's native cryptocurrency) in your wallet to use for transactions.

Use Remix Solidity IDE:

To run the program, you can use Remix, an online Solidity Integrated Development Environment (IDE). Access Remix by visiting the Remix website at https://remix.ethereum.org/.

Create a New Solidity File:

Once you are on the Remix website, create a new Solidity file by clicking on the "+" icon located in the left-hand sidebar.
Save the newly created file with a .sol extension, for example, "DegenGaming.sol."

Copy and Paste the Contract Code:

Copy the code from the "DegenGaming.sol" file (or "token.sol" file) that you want to execute.
Paste the copied code into your newly created "DegenGaming.sol" file in Remix.

Compile the Contract:

Click on the "Solidity Compiler" tab located in the left-hand sidebar.
Ensure that the "Compiler" option is set to the latest Solidity version (or another compatible version).
Click the "Compile" button to compile the contract code.

Deploy the Contract:

After successful compilation, Before deploying a smart contract, You have to connect remix with your wallet, then navigate to the "Deploy & Run Transactions" tab in the left-hand sidebar.
Select your contract from the dropdown menu, which should be named "DegenGaming" or similar.
Click the "Deploy" button to initiate the contract deployment process.

Enter the Contract Address:

Once the contract is deployed, you will receive a contract address. In the "At Address" input field, enter the contract address.

Interact with the Contract:

With the contract address entered, you can now interact with the deployed "DegenGaming" smart contract.

You can call various functions of the contract, such as minting tokens, burning tokens, transferring tokens, and more, directly within Remix without needing to specify the contract address since it has already been set.
By following these steps, you can execute and interact with the "DegenGaming" smart contract on the Avalanche Fuji Testnet using the Remix Solidity IDE.
```
