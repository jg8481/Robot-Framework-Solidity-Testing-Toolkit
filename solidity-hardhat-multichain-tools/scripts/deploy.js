const { ethers } = require("hardhat");

async function main() {

  const smartContractOwner = await ethers.getSigners();
  console.log(`TestToken Contract has been deployed from: ${smartContractOwner[0].address}`);
  const testToken = await ethers.getContractFactory('Token');
  console.log('TestToken will now be deployed...');
  const deployToken = await testToken.deploy();
  await deployToken.deployed();
  console.log(`TestToken has been deployed to: ${deployToken.address}`)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });