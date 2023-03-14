---
layout: default
---

# Robot Framework Solidity Testing Toolkit

[![Toolkit Checks](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions/workflows/toolkit-checks.yml/badge.svg)](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions/workflows/toolkit-checks.yml)

[![Security Checks](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions/workflows/security-checks.yml/badge.svg)](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions/workflows/security-checks.yml)

[![CodeQL](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions/workflows/github-code-scanning/codeql)

![Robot](./assets/images/robotframework-ethereum.png)

## Disclaimer

By using this software you understand the risks of Web3 and blockchain technologies. This toolkit is intended for testing and learning exciting concepts in the Web3 and blockchain industry with a security-minded self-education approach. The blockchain and DeFi ecosystems do not show mercy in any way to even the smallest mistakes. [I recommend that you self-educate yourself first and read MetaMask's security knowledge base before experimenting with this repository.](https://metamask.zendesk.com/hc/en-us/articles/360015489591-Basic-Safety-and-Security-Tips-for-MetaMask) **You are responsible for your own personal cryptocurrency funds and Web3 wallet private keys, and it is your personal responsibility to educate yourself to protect them.** Any misuse or mishandling of this software on any of the EVM compatible blockchain mainnets or testnets is at your own risk.

Also just a **friendly warning, DO NOT ATTEMPT TO SEND FUNDS to any of the** [**20 test accounts**](https://dev.to/alex_bobes/making-an-ethereum-bot-a-step-by-step-guide-3ol4) provided by `hardhat`. 

## Ethereum set the standard, but cross-chain is the future

[The capabilities of the Solidity programming language and the Ethereum platform in general are vast and growing every day](https://soliditylang.org/). One of the common usecases for Ethereum has been to approach it as a gigantic Web3 backend system. The very simple OpenZeppelin ERC20 `TestToken` and other smart contract examples included in this toolkit are only tiny slices of the bigger picture in comparison to what is being used today [in Web3 and DeFi production environments](https://dappradar.com/). In general when you approach people on the street and they hear the word `Ethereum`, the reactions you would probably get from them is "oh that's the thing I can buy on Coinbase or Binance and send to my parents on the other side of the world" or "that's the blockchain network that has all those worthless poo-coins right?". In reality, Ethereum was built for much immensely grander designs than the simple monetary usecases that most people are familiar with. [Vitalik Buterin and the other Ethereum co-founders originally sought to create a "World Computer".](https://cointelegraph.com/news/the-mind-behind-the-world-computer-ethereums-vitalik-buterin) As you browse through this documentation you will notice that **I am not attempting to try to create "generic keywords" for the Solidity language or the "World Computer" that smart contracts are deployed to, and you will see a lot of mostly non-generic transparent strategies in this repository.** As a busy person who is trying to actively learn blockchain technologies and is worried about the security of his own Web3 wallet (also concerned for the safety of all of yours as well), I will leave the generic blockchain automation keyword development for others to pursue. An important trend in the Ethereum ecosystem to pay more attention to is the [rising popularity of bridges](https://ethereum.org/en/bridges/) into many other types of blockchains, and [the current Web3 protocols that are evolving towards cross-chain communication](https://www.alchemy.com/overviews/cross-chain-vs-multichain). I have usecases of my own for cross-chain EVM (Ethereum Virtual Machine) projects and prefer to focus on my ideas for this toolkit, but I wanted to share my high-level strategies here and possibly hear your thoughts too if you want to reach out to me on [Robot Framework's Slack Group](https://robotframework.slack.com/).

## Solidity clean-room environment testing is safe and repeatable

This [multichain toolkit](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit) contains keyword-driven automation that helps **locally test EVM compatible Solidity smart contracts, [deploys them using a multichain approach](https://roycewells.io/writing/multichain-development/), and has the basic building blocks for creating blockchain event monitoring bots**. One of the primary components is a custom-made `robotframework-hardhat-remote-library.js` that was built using [hardhat](https://hardhat.org/) and [ethers.js](https://github.com/ethers-io/ethers.js/) libraries for [Web3](https://ethereum.org/en/web3/) development, and combined together using [comick's node-robotremoteserver](https://github.com/comick/node-robotremoteserver). This toolkit has been designed to [create local clean-room environment mainnet forks through Hardhat Network](https://hardhat.org/hardhat-network/docs/guides/forking-other-networks) for deploying smart contracts on multiple types of blockchains that support the EVM. I have included small checks and basic RPA automation scripts that work for Ethereum, Fantom, Avalanche, Polygon, but they can be adapted to cover many others as well by simply adjusting minor `hardhat` CLI options and altering the provided config files. Also all of the [automated checks in this repository are spending ZERO actual gas because they are mostly reading or interacting with simulated blockchains running on a local machine](https://ethereum.stackexchange.com/questions/18183/gas-costs-reading-data-is-this-free), and not sending testnet transactions (scroll down to see risks of frequently doing that) or touching anything on mainnets.

## "Ethereum is a Dark Forest" - Dan Robinson and Georgios Konstantopoulos

You may be wondering. What's so special about Hardhat Network, [Trufflesuite's Ganache](https://trufflesuite.com/docs/truffle/how-to/debug-test/test-your-contracts/#clean-room-environment), and "[clean-room environment testing](https://medium.com/0xcert/testing-smart-contracts-live-without-spending-gas-19920a55d65b)"? Isn't testing on any of the [Ethereum Testnets](https://ethereum.org/en/developers/docs/networks/#ethereum-testnets) enough since ETH on a testnet has zero real-world value? Technically all blockchain dApps and complex integrations with multiple existing smart contracts should always be deeply tested with testnets first before deploying them to a mainnet, but relying ONLY on testnets for testing is not always a good idea. For example, here are some disadvantages and possibly severe risks for testing on both Ethereum Testnets and Ethereum Mainnet.

**_Some Testnet testing disadvantages and risks:_**
- [Most of the time a testnet will be slow](https://www.reddit.com/r/ethereum/comments/cxdno6/ropsten_very_slow/)
- Even though it's a testnet you still need to worry about paying gas fees for every Metamask wallet transaction
- If you're using `hardhat` or `truffle` there is a risk that you can [expose your Metamask wallet private key in your deployment configuration files by accidentally pushing them into GitHub](https://consensys.net/blog/developers/how-to-avoid-uploading-your-private-key-to-github-approaches-to-prevent-making-your-secrets-public/)
- Deploying smart contracts to a blockchain testnet is immutable or permanent. [Which is exactly how mainnets behave as well](https://www.gemini.com/cryptopedia/blockchain-testnet-devnet-sandbox-crypto-mainnet#section-what-is-a-blockchain-testnet)
- If you are in the security sector of the blockchain industry, [testing on an Ethereum Testnet can have other possible serious risks](https://medium.com/immunefi/why-you-should-never-test-exploits-on-mainnet-or-public-testnets-7e904a2cbf05). Testnets are constantly being attacked on a daily basis. **Very bad actors are good at tracking all transactions on testnets and mainnets, which could lead to various security risks. One of those risks includes indirectly exposing your Metamask address to these bad actors**

**_Some Mainnet testing disadvantages and risks:_**
- [Very expensive to test on a mainnet](https://www.coingecko.com/en/coins/ethereum)
- You need to worry about paying real gas fees for every Metamask wallet transaction
- If you're using `hardhat` or `truffle`, similar to testnets, there is the [same risk of exposing your Metamask wallet private key](https://decrypt.co/30222/hacker-steals-1200-worth-of-ethereum-in-under-100-seconds)
- Deploying smart contracts to a blockchain mainnet is immutable or permanent. [It will stay there on the blockchain forever](https://academy.binance.com/en/glossary/immutability)
- Same possible security risks found on testnet that I mentioned above, [but on mainnet it can be much worse. Click here to read an interesting real-life Ethereum Mainnet "horror story"](https://www.paradigm.xyz/2020/08/ethereum-is-a-dark-forest)

**_Stay vigilant and protect yourself:_**

**There will be special cases and complex projects where frequent testing and smart contract deployments to Ethereum Testnet are unavoidable. I recommend setting up a "testing-only Metamask wallet" on a different browser (or maybe on a completely different laptop if possible), and also look into investing in a high-quality and well tested VPN service.** Always assume you are exposed and try your best to protect your internet connection and your personal workstation from exposure to scammers, malicious hackers, and other bad actors that are frequently found in the blockchain industry. Also don't let this dark side of the industry scare you away from these exciting technologies. Once you set up proper protections and establish good practices you should be ok.

## Why Robot Framework? Why not MochaJS etc.?

[MochaJS](https://mochajs.org/) is a good and flexible test framework, but it's not easy to figure out how it can handle the following types of tests...
- Model-based Testing
  - https://www.harryrobinson.net/
  - https://graphwalker.github.io/
- [Chaos Testing running in parallel with other tests](https://robocon.io/#online-robot-framework-and-endpoint-detection-agents-at-secureworks)
- [Parallel tests that require the tester to measure system resources while running various types of tests at the same time](https://github.com/jg8481/Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021-And-2022)

A lot of the automation in this repository is influenced by my [Robot-Framework-Lone-Tester-Strategies-RoboCon-2019](https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019), [Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019), and [Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021-And-2022](https://github.com/jg8481/Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021-And-2022) workshops. More information about these RoboCon workshops can be found on [robocon.io](https://robocon.io/archive) or watch this [YouTube video (click here)](https://youtu.be/lYHHIuNldM4) to see an example. Also just a general side note, I created this toolkit to demonstrate that there is more than one way to approach Web3, dApp, or blockchain-related testing and to encourage QA professionals who are interested in RPA tools. I also intended this to help suggest ideas to bridge [Robot Framework](https://robotframework.org/) into Web3 and blockchain, [as a means to experiment with new or cutting edge testing technologies focused on the security of EVM compatible smart contracts](https://github.com/saeidshirazi/Awesome-Smart-Contract-Security).

### Toolkit Roadmap 

In the future I plan to expand this toolkit into the following areas.
- Create a `robotframework-truffle-remote-library.js` using the [Truffle toolkit](https://trufflesuite.com/), and design similar features that are found in  `robotframework-hardhat-remote-library.js`
  - Progress:
    - (February 12, 2023 - **Ready To Use**) Created a working Truffle Suite library using a similar design as the Hardhat library, but utilizes [web3.js](https://web3js.org) and added a few different tests too.
- Create more static analysis, security, and vulnerability scanning RPA automation integrated with popular tools in the Web3 and blockchain industry
- Create RPA and `robotframework-hardhat-remote-library.js` powered multichain bots utilizing [Infura RPC nodes](https://infura.io/), [Hardhat toolkit](https://hardhat.org/), and [ethers.js](https://github.com/ethers-io/ethers.js/)
- Create RPA and Alchemy powered bots utilizing [their SDK](https://www.alchemy.com/sdk) and [RPC nodes]().
- Attempt to create Robot Framework automation utilizing the [Foundry toolkit](https://github.com/foundry-rs/foundry)
- Create Metamask automation using [SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary) and [robotframework-browser (a Playwright library)](https://github.com/MarketSquare/robotframework-browser)
- Create a Robot Framework Model-based Testing example utilizing similar concepts found in my [PaBot-Android-Device-Graphwalker-Examples.robot](https://github.com/jg8481/Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021-And-2022/blob/main/Workshop-Examples/Tests/Workshop-Part-Two/PaBot-Android-Device-Graphwalker-Examples.robot#L23)
- Play around with some Chaos Testing ideas for dApps

### Technical Requirements

The following are the basic technical requirements needed to run these automated checks. Please note that this entire toolkit was developed on a MacOS machine, but should also work for most Linux users (preferably most current Ubuntu LTS versions etc.) and I would keep an eye on whatever the `hardhat` or `truffle` (source: https://github.com/trufflesuite/ganache-ui/releases) communities recommend for Linux distributions.
- Python 3 -> https://www.python.org/downloads/
- NodeJS 18 -> https://nodejs.org/en/ or use https://github.com/nvm-sh/nvm
  - If you're using `nvm`, you can run `nvm install 18` to install version 18
  - If you are using a MacOS or Linux machine, the `Install-Tools-On-MacOS-Or-Linux` command below is a quick install
- Robot Framework -> https://robotframework.org
- Create your own [free Infura account](https://www.infura.io/) or [free Alchemy account](https://www.alchemy.com/), then **set up your own API keys**
- Replace all instances of `<your-infura-api-key-goes-here>` in the `Avalanche.config.js` and `Ethereum.config.js` configuration files. Also replace `<your-alchemy-api-key-goes-here>` in the `Polygon.config.js` configuration file.

## Quick Start Guide

Before running any of the automation first make sure that all of the basic technical requirements are installed and working, then you can run `bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux`. After the installation script successfully finishes you should be able to run any of the following commands without problems.

### Current Toolkit Capabilities
```
You can view just this help menu again (without triggering any automation) by running 'bash ./start-solidity-qa-workflows.sh -h' or 'bash ./start-solidity-qa-workflows.sh --help'.

---->>>> Local Solidity Test Environment Setup Commands <<<<----
bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux
bash ./start-solidity-qa-workflows.sh Start-Default-Hardhat-Network-And-Robotremoteserver
bash ./start-solidity-qa-workflows.sh Start-Multichain-Hardhat-Network-And-Robotremoteserver
bash ./start-solidity-qa-workflows.sh Start-Default-Truffle-Develop-And-Robotremoteserver
bash ./start-solidity-qa-workflows.sh Stop-Local-Blockchain-Nodes-And-Delete-Logs

---->>>> Solidity Static Analysis And Security Testing Commands <<<<----
bash ./start-solidity-qa-workflows.sh Run-Solidity-Static-Analysis

---->>>> Hardhat Deployment Commands Powered by Robot Framework RPA (NOTE: These scripts are capable of deploying to Mainnets or Testnets!) <<<<----
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Ethereum-RPA-Deployment
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Fantom-RPA-Deployment
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Polygon-RPA-Deployment
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Avalanche-RPA-Deployment

---->>>> Truffle Deployment Commands Powered by Robot Framework RPA (NOTE: These scripts are capable of deploying to Mainnets or Testnets!) <<<<----
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Truffle-Ethereum-RPA-Deployment

---->>>> Interactive Tests For Deployed Smart Contracts Using Hardhat (NOTE: These tests can run on multiple EVM Compatible Blockchains!) <<<<----
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Tests-Default-NonForked-Hardhat-Network
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Tests-Forked-Mainnet-Hardhat-Network

---->>>> Interactive Tests For Deployed Smart Contracts Using Truffle Suite <<<<----
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Tests-Default-Truffle-Develop-Instance
```

[Click here to see examples of how this automation toolkit works.](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit#example-workflow-1---deploy-then-test-a-smart-contract-using-the-built-in-hardhat-network-ethereum-node-and-node-robotremoteserver-on-macos-or-linux)
