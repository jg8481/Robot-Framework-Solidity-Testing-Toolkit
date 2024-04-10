require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      forking: {
        url: "https://mainnet.infura.io/v3/<your-infura-api-key-goes-here>", // Mainnet. To use this RPC, you need to create a free Infura account and replace "<your-infura-api-key-goes-here>".
        chainId: 31337,
        enabled: true,
      },
    sepolia: {
      url: "https://sepolia.infura.io/v3/<your-infura-api-key-goes-here>", // Sepolia Testnet. To use this RPC, you need to create a free Infura account and replace "<your-infura-api-key-goes-here>".
      //accounts: [<Your wallet private key can go here...WARNING, do not use this if you only want to do local testing. ALWAYS PROTECT YOUR PRIVATE KEY!!!>],
      chainId: 11155111,
    }
  }
}
};

