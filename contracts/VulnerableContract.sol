// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableContract {
    address public owner;
    uint256 public funds;

    constructor() {
        owner = msg.sender;
    }

    // Vulnerable function
    function addFunds() public payable {
        funds += msg.value;
    }

    // Vulnerable function
    function withdrawFunds(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw funds");
        require(amount <= funds, "Insufficient funds");
        payable(msg.sender).transfer(amount);
    }

    // Function to transfer ownership - should be external but is public
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only owner can transfer ownership");
        owner = newOwner;
    }
}
