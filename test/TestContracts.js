const VulnerableContract = artifacts.require('VulnerableContract');
const AttackContract = artifacts.require('AttackContract');

contract('VulnerableContract', (accounts) => {
  it('should deploy contracts', async () => {
    const vulnerable = await VulnerableContract.deployed();
    assert(vulnerable.address !== '');
  });

  it('should allow the attack contract to take ownership', async () => {
    const vulnerable = await VulnerableContract.deployed();
    const attack = await AttackContract.new(vulnerable.address);
    await attack.exploitOwnership();
    const newOwner = await vulnerable.owner();
    assert(newOwner === attack.address);
  });
});

