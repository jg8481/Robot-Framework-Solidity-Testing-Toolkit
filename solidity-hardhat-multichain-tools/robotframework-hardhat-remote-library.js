'use strict';

const robot = require('robotremote');
const assert = require('assert');
const { ethers } = require("hardhat");

var lib = module.exports;

/**
 * This robotframework-hardhat-remote-library.js will focus on testing 
 * the specific smart contracts in the "contracts" folder. Eventually
 * more smart contracts for testing will be added to the 
 * "solidity-smart-contracts-for-testing" folder. The keywords below will 
 * be updated when more smart contracts are added.
 * 
 * IMPORTANT NOTE: Replace the "CONTRACT_ADDRESS" environment variable in the
 * "hardhat-environment-variables.env" file with the address of your contract 
 * deployed through Hardhat, or keep it as-is using "0x5fbdb2315678afecb367f032d93f642f64180aa3". 
 * On Fantom mainnet, this test will reveal an unrelated token deployed by someone else.
 */

lib.getContract = async function(str) {
    const checkContract = await ethers.getContractAt('Token', str);
    var timeStamp = new Date();
    console.log(`getContract keyword ran on ${timeStamp}`);
    return { checkContract };
};

lib.getName = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const name = await testToken.name();
    var timeStamp = new Date();
    console.log(`getName keyword ran on ${timeStamp}`);
    return { name };
};

lib.getSymbol = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const symbol = await testToken.symbol();
    var timeStamp = new Date();
    console.log(`getSymbol keyword ran on ${timeStamp}`);
    return { symbol };
};

lib.getDefaultDecimals = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    var timeStamp = new Date();
    console.log(`getDefaultDecimals keyword ran on ${timeStamp}`);
    return { decimals };
};

lib.getTotalSupply = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const totalSupply = await testToken.totalSupply();
    const totalSupplyCommify = await ethers.utils.commify(totalSupply)
    const totalSupplyFormatUnits = await ethers.utils.formatUnits(totalSupply, decimals);
    var timeStamp = new Date();
    console.log(`getTotalSupply keyword ran on ${timeStamp}`);
    return { totalSupplyFormatUnits };
};

lib.getTokenBalanceAddress = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    var timeStamp = new Date();
    console.log(`getTokenContractAddress keyword ran on ${timeStamp}`);
    return { testTokenAddress };
};

lib.getBalanceOfAddress = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    const testTokenBalance = await testToken.balanceOf(testTokenAddress);
    const addressBalance = ethers.utils.formatUnits(testTokenBalance, decimals);
    var timeStamp = new Date();
    console.log(`getBalanceOfAddress keyword ran on ${timeStamp}`);
    return { addressBalance };
};

lib.getReceiverTargetAddress = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const receivingAddress = testTokenSigners[1].address;
    var timeStamp = new Date();
    console.log(`getReceiverTargetAddress keyword ran on ${timeStamp}`);
    return { receivingAddress };
};

lib.transferToTargetAddress = async function(str) {
    const amountForTransfer = 80000;
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const receivingAddress = testTokenSigners[1].address;
    await testToken.transfer(receivingAddress, ethers.utils.parseUnits(amountForTransfer.toString(), decimals));
    const receiverBalance = await testToken.balanceOf(receivingAddress);
    const receiverBalanceFormatUnits = await ethers.utils.formatUnits(receiverBalance, decimals);
    var timeStamp = new Date();
    console.log(`transferToTargetAddress keyword ran on ${timeStamp}`);
    return { receiverBalanceFormatUnits };
};

lib.approveSpenderAmount = async function(str) {
    const amountApproved = 200000;
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    const signerTestToken = testToken.connect(testTokenSigners[1]); 
    await signerTestToken.approve(testTokenAddress, ethers.utils.parseUnits(amountApproved.toString(), decimals));
    var timeStamp = new Date();
    console.log(`approveSpenderAmount keyword ran on ${timeStamp}`);
    const approvalSuccess = 'Amount has been approved'
    return { approvalSuccess };
};

lib.showSpenderAllowance = async function(str) {
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    const receivingAddress = testTokenSigners[1].address;
    const spenderAllowance = await testToken.allowance(receivingAddress, testTokenAddress);
    const showAllowance = await ethers.utils.formatUnits(spenderAllowance, decimals)
    var timeStamp = new Date();
    console.log(`showSpenderAllowance keyword ran on ${timeStamp}`);
    return { showAllowance };
};

lib.transferFromTargetAddress = async function(str) {
    const amountForTransfer = 700;
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    const senderAddress = testTokenSigners[1].address;
    await testToken.transferFrom(senderAddress, testTokenAddress, ethers.utils.parseUnits(amountForTransfer.toString(), decimals));
    const testTokenBalance = await testToken.balanceOf(testTokenAddress);
    const senderBalance = await testToken.balanceOf(senderAddress);
    const senderBalanceFormatUnits = await ethers.utils.formatUnits(senderBalance, decimals);
    const transferAllowance = await testToken.allowance(senderAddress, testTokenAddress);
    console.log(`Sender's available allowance: ${ethers.utils.formatUnits(transferAllowance, decimals)}`);
    var timeStamp = new Date();
    console.log(`transferFromTargetAddress keyword ran on ${timeStamp}`);
    return { senderBalanceFormatUnits };
};

lib.increaseSpenderAllowance = async function(str) {
    const increaseSpenderAmount = 2000;
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    const receivingAddress = testTokenSigners[1].address;
    const signerTestToken = testToken.connect(testTokenSigners[1]); 
    await signerTestToken.increaseAllowance(testTokenAddress, ethers.utils.parseUnits(increaseSpenderAmount.toString(), decimals));
    const spenderAllowance = await testToken.allowance(receivingAddress, testTokenAddress);
    const showIncreasedAllowance = await ethers.utils.formatUnits(spenderAllowance, decimals)
    console.log(`Allowance will be increased by this amount: ${increaseSpenderAmount}`)
    var timeStamp = new Date();
    console.log(`increaseSpenderAllowance keyword ran on ${timeStamp}`);
    return { showIncreasedAllowance };
};


lib.decreaseSpenderAllowance = async function(str) {
    const decreaseSpenderAmount = 1000;
    const deployedContract = await ethers.getContractFactory('Token');
    const testToken = await deployedContract.attach(str);
    const decimals = await testToken.decimals();
    const testTokenSigners = await ethers.getSigners();
    const testTokenAddress = testTokenSigners[0].address;
    const receivingAddress = testTokenSigners[1].address;
    const signerTestToken = testToken.connect(testTokenSigners[1]); 
    await signerTestToken.decreaseAllowance(testTokenAddress, ethers.utils.parseUnits(decreaseSpenderAmount.toString(), decimals));
    const spenderAllowance = await testToken.allowance(receivingAddress, testTokenAddress);
    const showDecreasedAllowance = await ethers.utils.formatUnits(spenderAllowance, decimals)
    console.log(`Allowance will be decreased by this amount: ${decreaseSpenderAmount}`)
    var timeStamp = new Date();
    console.log(`decreaseSpenderAllowance keyword ran on ${timeStamp}`);
    return { showDecreasedAllowance };
};


if (!module.parent) {
    const server = new robot.Server([lib], { host: 'localhost', port: 8270 });
}
