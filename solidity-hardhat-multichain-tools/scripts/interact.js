const { ethers } = require("hardhat");

async function main() {
    console.log('Getting list of accounts available on Hardhat Localhost...');
    const accounts = await ethers.provider.listAccounts();
    console.log(accounts);
    console.log('Getting the target contract...');
    const contractAddress = '0x5fbdb2315678afecb367f032d93f642f64180aa3';
    const Token = await ethers.getContractFactory('Token');
    const testToken = await Token.attach(contractAddress);
    console.log('Getting token name...');
    const name = await testToken.name();
    console.log(`Token Name: ${name}\n`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exitCode = 1;
    });
