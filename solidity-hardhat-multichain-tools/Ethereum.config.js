require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      forking: {
        url: "https://mainnet.infura.io/v3/<your-infura-api-key-goes-here>", // To use this RPC, you need to create a free Infura account and replace "<your-infura-api-key-goes-here>".
        chainId: 31337,
        enabled: true,
      },
    rinkeby: {
      url: "https://rinkeby.infura.io/v3/<your-infura-api-key-goes-here>", // Rinkeby Testnet
      //accounts: [<Your wallet private key can go here...WARNING, do not use this if you only want to do local testing. ALWAYS PROTECT YOUR PRIVATE KEY!!!>]
    },
    goerli: {
      url: "https://goerli.infura.io/v3/<your-infura-api-key-goes-here>", // Goerli Testnet
      //accounts: [<Your wallet private key can go here...WARNING, do not use this if you only want to do local testing. ALWAYS PROTECT YOUR PRIVATE KEY!!!>]
    }
  }
}
};

