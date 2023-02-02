require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      forking: {
        url: "https://avalanche-mainnet.infura.io/v3/<your-infura-api-key-goes-here>", // To use this RPC, you need to create a free Infura account and replace "<your-infura-api-key-goes-here>".
        chainId: 43114,
        enabled: true,
      }
    }
}
};

