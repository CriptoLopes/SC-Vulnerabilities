# Vulnerable Smart Contract

This repository contains a smart contract with known vulnerabilities related to visibility modifiers and a contract to exploit these vulnerabilities.

## VulnerableContract.sol

This contract contains the following vulnerabilities:
1. `addFunds()` function is `public`, allowing anyone to add funds.
2. `withdrawFunds()` function is `public`, but is protected by an ownership check.
3. `transferOwnership()` function is `public` instead of `external`, allowing unintended ownership transfers if called incorrectly.

## AttackContract.sol

This contract is designed to exploit the vulnerabilities in `VulnerableContract.sol`.

## Steps to Deploy and Exploit

1. Compile and deploy `VulnerableContract.sol`:
    ```bash
    truffle compile
    truffle migrate
    ```

2. Deploy `AttackContract.sol` with the address of the deployed `VulnerableContract`:
    ```bash
    truffle console
    const attack = await AttackContract.new("ADDRESS_OF_VULNERABLE_CONTRACT")
    ```

3. Exploit the `transferOwnership` vulnerability:
    ```bash
    await attack.exploitOwnership()
    ```

4. Add funds to the vulnerable contract through the attack contract:
    ```bash
    await attack.addFunds({value: web3.utils.toWei("1", "ether")})
    ```

5. Drain funds from the vulnerable contract:
    ```bash
    await attack.drainFunds(web3.utils.toWei("1", "ether"))
    ```

## How to Check the Vulnerabilities

1. Verify the owner of the `VulnerableContract` before and after exploitation:
    ```bash
    const vulnerable = await VulnerableContract.deployed()
    await vulnerable.owner()
    ```

2. Check the balance of the `VulnerableContract` before and after adding/draining funds:
    ```bash
    web3.eth.getBalance(vulnerable.address)
    ```

## Notes

- These contracts are for educational purposes only. Do not use them in production environments.
- Always follow best practices and conduct thorough security audits before deploying smart contracts.
