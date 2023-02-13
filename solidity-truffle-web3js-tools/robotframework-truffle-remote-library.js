'use strict';

const robot = require('robotremote');
const assert = require('assert');
const web3 = require("web3");
const contract = require("@truffle/contract");

const rpc = new web3('http://localhost:8545');
const abi = require('./build/contracts/Token.json').abi;

/**
 * This robotframework-truffle-remote-library.js will focus on testing 
 * the specific smart contracts in the "contracts" folder. Eventually
 * more smart contracts for testing will be added to the 
 * "solidity-smart-contracts-for-testing" folder. The keywords below will 
 * be updated when more smart contracts are added.
 */

var lib = module.exports;

lib.getAllAvailableAccounts = async function() {
    const accounts = await rpc.eth.getAccounts();
    var timeStamp = new Date();
    console.log(`getAllAvailableAccounts keyword ran on ${timeStamp}`);
    return { accounts };
};

lib.getContract = async function(str) {
    const checkContract = new rpc.eth.Contract(abi, str);
    var timeStamp = new Date();
    console.log(`getContract keyword ran on ${timeStamp}`);
    return { checkContract };
};

lib.getName = async function(str) {
    const testToken = new rpc.eth.Contract(abi, str);
    const name = await testToken.methods.name().call();
    var timeStamp = new Date();
    console.log(`getName keyword ran on ${timeStamp}`);
    return { name };
};

lib.getSymbol = async function(str) {
    const testToken = new rpc.eth.Contract(abi, str);
    const symbol = await testToken.methods.symbol().call();
    var timeStamp = new Date();
    console.log(`getSymbol keyword ran on ${timeStamp}`);
    return { symbol };
};

lib.getDefaultDecimals = async function(str) {
    const testToken = new rpc.eth.Contract(abi, str);
    const decimals = await testToken.methods.decimals().call();
    var timeStamp = new Date();
    console.log(`getDefaultDecimals keyword ran on ${timeStamp}`);
    return { decimals };
};

lib.getTotalSupply = async function(str) {
    const testToken = new rpc.eth.Contract(abi, str);
    const totalSupply = await testToken.methods.totalSupply().call();
    var timeStamp = new Date();
    console.log(`getTotalSupply keyword ran on ${timeStamp}`);
    return { totalSupply };
};

lib.getGasEstimate = async function(str) {
    const check = new rpc.eth.Contract(abi, str);
    let gasEstimation = await check.methods.decimals().estimateGas({gas: 5000000}, function(error, gasAmount){if(gasAmount == 5000000) console.log('TestToken method is out of gas');});
    var timeStamp = new Date();
    console.log(`getGasEstimate keyword ran on ${timeStamp}`);
    return { gasEstimation };
};


lib.getCurrentGasPrice = async function(str) {
    const check = new rpc.eth.Contract(abi, str);
    let gasPrice = await rpc.eth.getGasPrice();
    var timeStamp = new Date();
    console.log(`getCurrentGasPrice keyword ran on ${timeStamp}`);
    return { gasPrice };
};

if (!module.parent) {
    const server = new robot.Server([lib], { host: 'localhost', port: 8270 });
}
