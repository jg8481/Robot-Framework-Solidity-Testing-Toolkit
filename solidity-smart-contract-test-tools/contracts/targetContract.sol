// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

/**
 * Replace every line past this comment with the contract code that needs to be tested.
 */

contract BEP20 {

address[16] public adopters;

// Adopting a pet
function adopt(uint petId) public returns (uint) {
  require(petId >= 0 && petId <= 15);

  adopters[petId] = msg.sender;

  return petId;
}

// Retrieving the adopters
function getAdopters() public view returns (address[16] memory) {
  return adopters;
}

}