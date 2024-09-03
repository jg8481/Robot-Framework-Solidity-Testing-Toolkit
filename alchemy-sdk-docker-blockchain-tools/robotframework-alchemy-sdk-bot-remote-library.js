'use strict';

const robot = require('robotremote');
const assert = require('assert');
const { Alchemy, Network } = require('alchemy-sdk');

const settings = {
  apiKey: "<your-alchemy-api-key-goes-here>",
  network: Network.ETH_MAINNET,
};
const alchemy = new Alchemy(settings);


var lib = module.exports;

/**
 * This robotframework-alchemy-sdk-remote-library.js will focus on the Alchemy SDK  
 * for blockchain interactions and utilizing the Alchemy Node Infrastructure. Please go to
 * the following Alchemy documentation knowledge base to see more information.
 * 
 * https://docs.alchemy.com/reference/alchemy-sdk-quickstart
 * 
 * IMPORTANT NOTE: Replace the "REPLACE_WITH_YOUR_API_KEY" above with a valid Alchemy key. 
 */


lib.getNFTOwnerInformation = async function() {
    const ownerAddr = "vitalik.eth";
    console.log("fetching NFTs for address:", ownerAddr);
    console.log("...");
    //const nftsForOwner = await alchemy.nft.getNftsForOwner("vitalik.eth");
    const nftsForOwner = await alchemy.nft.getNftsForOwner(ownerAddr);
    const nftTotal = nftsForOwner["totalCount"];
    console.log("number of NFTs found:", nftsForOwner.totalCount);
    console.log("...");
    for (const nft of nftsForOwner.ownedNfts) {
      console.log("===");
      console.log("contract address:", nft.contract.address);
      console.log("token ID:", nft.tokenId);
    }
    return { nftTotal, ownerAddr };
};

lib.getNFTMetadata = async function() {
// Fetch metadata for a particular NFT:
    console.log("fetching metadata for a Crypto Coven NFT...");
    const response = await alchemy.nft.getNftMetadata(
      "0x5180db8F5c931aaE63c74266b211F580155ecac8",
      "1590"
    );
    console.log("===");
    console.log("NFT Collection: ", response.contract.name);
    console.log("NFT name: ", response.name);
    console.log("Token type: ", response.tokenType);
    console.log("NFT description: ", response.description);
    console.log("===");
    console.log("Full NFT Metadata Resonse: ", response);
    console.log("===");
    const checkNFTCollectionName = response.contract.name;
    const checkNFTDeployerAddress = response.contract.contractDeployer || 'N/A';
    const checkSpecificNFTName = response.name || 'N/A';
    const checkTokenType = response.tokenType || 'N/A';
    const checkDeployedBlockNumber = response.contract.deployedBlockNumber || 'N/A';
    const checkOpenSeaFloorPrice = response.contract.openSeaMetadata.floorPrice || 'N/A';
    const checkNFTDiscordURL = response.contract.openSeaMetadata.discordUrl || 'N/A';
 // return { response };
    return { 
        checkNFTCollectionName, 
        checkNFTDeployerAddress,
        checkSpecificNFTName, 
        checkTokenType, 
        checkDeployedBlockNumber,
        checkOpenSeaFloorPrice,
        checkNFTDiscordURL
    };
};


if (!module.parent) {
    const server = new robot.Server([lib], { host: 'localhost', port: 8270 });
}
