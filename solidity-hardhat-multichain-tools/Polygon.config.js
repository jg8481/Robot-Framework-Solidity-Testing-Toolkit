require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      forking: {
        url: "https://polygon-mainnet.g.alchemy.com/v2/<your-alchemy-api-key-goes-here>",
        //url: "https://rpc-mainnet.matic.quiknode.pro", // An alternate Polygon RPC that also works in case you don't want to use Alchemy.
        chainId: 137,
        enabled: true,
      }
    }
}
};
