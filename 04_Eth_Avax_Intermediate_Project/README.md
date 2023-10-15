## Introduction 

The "DegenGaming" smart contract represents a robust and versatile Ethereum-based solution designed for gaming purposes within the Avalanche Fuji Test Network. This contract serves as a foundational building block for creating immersive gaming experiences, enabling game developers to manage in-game assets, tokens, and transactions seamlessly. Made for Eth + Avax Intermediate Module 4 Project on the Metacrafters learning platform.

Let's delve into the salient features of this contract:


## Code
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DegenToken {

    address public owner;
    string public name = "Degen Gaming";
    string public symbol = "DGN";
    uint8 public decimals = 10;
    uint256 public totalSupply = 0;

    constructor() {
        owner = msg.sender;
        nftaccs[0] = Nft("Degen Sword", 50);
        nftaccs[1] = Nft("Degen Stone", 100);
        nftaccs[2] = Nft("Degen Coin", 200);
        nftaccs[3] = Nft("Degen kit", 250);
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "Only the owner is allowed to use this function");
        _;
    }

    mapping(address => uint256) private balance;
    mapping(address => mapping(address => uint256)) private allowances;
    mapping(uint256 => Nft) public nftaccs;

    struct Nft {
        string name;
        uint256 price;
    }

    event Mint(address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed from, string itemName);

    function mint(address to, uint256 amount) external ownerOnly {
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Amount must be greater than zero");

        totalSupply += amount;
        balance[to] += amount;

        emit Mint(to, amount);
        emit Transfer(address(0), to, amount);
    }

    function balanceOf(address accountAddress) external view returns (uint256) {
        return balance[accountAddress];
    }

    function transfer(address receiver, uint256 amount) external returns (bool) {
        require(receiver != address(0), "Invalid recipient address");
        require(balance[msg.sender] >= amount, "Insufficient balance for transfer");

        balance[msg.sender] -= amount;
        balance[receiver] += amount;

        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function transferFrom(address sender, address receiver, uint256 amount) external returns (bool) {
        require(sender != address(0), "Invalid sender address");
        require(receiver != address(0), "Invalid recipient address");
        require(balance[sender] >= amount, "Insufficient balance for transfer");
        require(allowances[sender][msg.sender] >= amount, "Allowance exceeded");

        balance[sender] -= amount;
        balance[receiver] += amount;
        allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, receiver, amount);
        return true;
    }

    function burn(uint256 amount) external {
        require(balance[msg.sender] >= amount, "Insufficient balance for burn");
        require(amount > 0, "Amount must be greater than zero");

        balance[msg.sender] -= amount;
        totalSupply -= amount;

        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
    }

    function redeem(uint256 accId) external returns (string memory) {
        require(balance[msg.sender] > 0, "Balance is too low for redemption");
        require(nftaccs[accId].price > 0, "Invalid item ID");
        require(balance[msg.sender] >= nftaccs[accId].price, "Insufficient balance for redemption");

        balance[msg.sender] -= nftaccs[accId].price;

        emit Redeem(msg.sender, nftaccs[accId].name);

        return nftaccs[accId].name;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        
        require(spender != address(0), "Invalid spender address");
        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        
        return true;
    }
}
```

**Token Minting (Mint Function):**

One of the central features of the contract is the ability to mint tokens, which can be achieved using the mint function. Minting tokens increases the overall token supply and allocates the newly minted tokens to a specific user's address. This functionality is instrumental for game developers as it allows them to generate in-game currency or rewards and distribute them to players as needed.

**Token Burning (Burn Function):**

Users are empowered to burn (permanently remove from circulation) their own tokens through the burn function. The process of token burning reduces the total token supply, providing flexibility for implementing various mechanisms within the game. For example, it can be used to simulate the removal of currency from circulation or introduce deflationary dynamics. In-Game Item Store (GameStore Function):

The contract features an in-game item store that can be managed by the contract owner. The owner can use the GameStore function to add items to the store, each with a unique identifier, a name, and a price. This functionality lays the groundwork for the creation of a virtual marketplace within the game, allowing players to purchase items using tokens.

**Token Transfers (Transfer Function):**

Users can transfer tokens to other players using the transfer function. This peer-to-peer token transfer mechanism enables in-game transactions, facilitating the exchange of currency or items among players.

**Item Redemption (Itemredeem Function):**

A notable feature is the ability for users to redeem in-game items from the store in exchange for tokens. The Itemredeem function facilitates this process, deducting the required token amount from the user's balance and marking the item as redeemed. This enhances the interactive gaming experience, allowing players to acquire virtual assets within the game.

**Balances and Redemption Tracking:**

The contract maintains a balance of tokens for each user through the balance mapping, ensuring transparency regarding token holdings. Additionally, it tracks the items that each user has redeemed and their respective counts using redeemedItems and redeemedItemCount mappings.

The "DegenGaming" smart contract demonstrates a comprehensive set of functionalities, making it a valuable tool for game developers looking to implement blockchain-based gaming features, manage in-game economies, and provide players with engaging gaming experiences on the Avalanche Fuji Test Network.

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
