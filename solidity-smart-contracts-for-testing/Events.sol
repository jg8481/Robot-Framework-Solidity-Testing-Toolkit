// SPDX-License-Identifier: MIT
// https://github.com/solidity-by-example/solidity-by-example.github.io/blob/gh-pages/src/pages/events/Events.sol
pragma solidity ^0.8.17;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}
