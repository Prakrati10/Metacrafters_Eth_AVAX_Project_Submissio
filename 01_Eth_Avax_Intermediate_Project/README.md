## Introduction 

The code represents a Solidity smart contract named Exception that showcases exception handling using require(), assert(), and revert() statements. Overall The main objective of this smart contract is to demonstrate different ways of handling exceptions and errors in Solidity.

## Code Explanation - Error Handling Solidity Contract

This Solidity contract, named ErrorHandlingContract, serves as a simple example to demonstrate various error handling mechanisms in Solidity. It includes the usage of require, assert, and revert to handle different types of errors that can occur during smart contract execution.|

**State Variables**
```solidity
uint256 public balance = 1000;
address public owner;
```

uint256 public balance: This variable represents the balance of the contract and is initialized to 1000.
address public owner: The owner variable stores the address of the contract creator.

**Constructor**

```solidity
constructor() {
    owner = msg.sender;
}
```

The constructor sets the owner of the contract to the address of the account that deploys the contract. This address is stored in the owner state variable.

**Functions**

**deposit(uint256 amount)**
```solidity
   function deposit(uint256 amount) public {

        // Test 'Require' Function to handle error

        require(amount > 0, "Amount must be greater than 0");
        balance += amount;
    }
```

This function allows users to deposit a specified amount of cryptocurrency into the contract's balance.
It utilizes the require function to ensure that the provided amount is greater than 0.
If the requirement is met, the amount is added to the contract's balance.

**withdraw(uint256 amount)**
```solidity
    function withdraw(uint256 amount) public {

        require(msg.sender == owner, "Only the owner can withdraw");
        require(amount > 0, "Amount must be greater than 0");
        require(balance >= amount, "Insufficient balance");
        balance -= amount;
    }
```
This function permits the contract owner (the account that deployed the contract) to withdraw a specified amount of cryptocurrency from the contract's balance.
It uses require statements to ensure that:
The caller of the function is the contract owner.
The provided amount is greater than 0.
Sufficient balance is available in the contract to perform the withdrawal.
If all requirements are met, the amount is subtracted from the contract's balance.

**assertExample(uint256 a, uint256 b)**
```solidity
    function assertExample(uint256 a, uint256 b) public pure returns (uint256) {

        // Test 'assert' function to handle error

        assert(a <= b);
        return a - b;
    }
```

This function showcases the use of the assert statement.
It checks if a is less than or equal to b.
If the assertion fails (i.e., a is greater than b), the transaction will revert with an error message.

**revertExample(uint256 a, uint256 b)**
```solidity
    function revertExample(uint256 a, uint256 b) public pure returns (uint256) {

        if (a <= b) {
            // Test 'revert' function to handle error

            revert("a must be greater than or equal to b");
        }

        return a - b;
    }
```

This function demonstrates the revert function.
If a is not greater than or equal to b, it explicitly triggers a revert with the message "a must be greater than or equal to b.

