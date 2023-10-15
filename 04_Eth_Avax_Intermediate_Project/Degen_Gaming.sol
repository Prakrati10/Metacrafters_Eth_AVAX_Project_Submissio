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
