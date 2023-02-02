# Robot Framework Solidity Testing Toolkit

![Robot](./notes-images-and-demonstrations/robotframework-ethereum.png)

## Disclaimer

By using this software you understand the risks of Web3 and blockchain technologies. This toolkit is intended for testing and learning concepts in the Web3 and blockchain industry. **You are responsible for your own personal cryptocurrency funds and Web3 wallet private keys, and it is your personal responsibility to protect them.** Any misuse or mishandling of this software on any of the EVM compatible blockchain mainnets or testnets is at your own risk.

Also just a **friendly warning, DO NOT ATTEMPT TO SEND ANY FUNDS to any of the** [**20 test accounts**](https://dev.to/alex_bobes/making-an-ethereum-bot-a-step-by-step-guide-3ol4) provided by `hardhat`. 

## General Information

This [toolkit](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit) contains automation that helps **locally test EVM compatible smart contracts written in Solidity, [deploy them using a multichain approach](https://roycewells.io/writing/multichain-development/), and has the basic building blocks for creating blockchain event monitoring bots**. One of the primary components is a custom-made `robotframework-hardhat-remote-library.js` that was built using [hardhat]() and [ethers.js]() libraries for [Web3](https://ethereum.org/en/web3/) development, and combined together using [comick's node-robotremoteserver](https://github.com/comick/node-robotremoteserver). This toolkit is being designed to [create local mainnet forks through hardhat](https://hardhat.org/hardhat-network/docs/guides/forking-other-networks) for deploying smart contracts on multiple types of blockchains that support the EVM (Ethereum Virtual Machine). 

The examples in this toolkit include tests and RPA automation that work for Ethereum, Fantom, Avalanche, Polygon, and it can cover many others as well by simply adjusting minor `hardhat` CLI options and altering the provided config files. In the future I plan to expand this toolkit into the following areas.
- Create a `robotframework-truffle-remote-library.js` with similar features that are found in  `robotframework-hardhat-remote-library.js`.
- Create more static analysis, security, and vulnerability scanning RPA automation integrated with popular tools in the Web3 and blockchain industry.
- Create RPA and `robotframework-hardhat-remote-library.js` powered cross-chain bots utilizing `Infura`, `hardhat`, and `ethers.js`.

A lot of the automation in this repo is heavily influenced by my [Robot-Framework-Lone-Tester-Strategies-RoboCon-2019](https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019) and [Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019) workshops. More information about these RoboCon workshops can be found here... https://robocon.io/#workshops

The following are the basic technical requirements needed to run these automated checks. Please note that this entire toolkit was developed on a MacOS machine, but should also work for most Linux users (preferably most current Ubuntu LTS versions etc.) and I would keep an eye on whatever the `hardhat` or `truffle` (source: https://github.com/trufflesuite/ganache-ui/releases) communities recommend for Linux distributions.
- Python 3 -> https://www.python.org/downloads/
- NodeJS 18 -> https://nodejs.org/en/ or use https://github.com/nvm-sh/nvm
  - If you're using `nvm`, you can run `nvm install 18` to install version 18
  - If you are using a MacOS or Linux machine, the `Install-Tools-On-MacOS-Or-Linux` command below is a quick install
- Robot Framework -> https://robotframework.org
- Create your own [free Infura account](https://www.infura.io/) and **set up your own API key**.
- Replace all instances of `<your-infura-api-key-goes-here>` in the `Avalanche.config.js` and `Ethereum.config.js` configuration files.

## Quick Start Guide

Before running any of the automation first make sure that all of the basic technical requirements are installed and working, then you can run `bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux`. After the installation script successfully finishes you should be able to run any of the following commands without problems.

```
You can view just this help menu again (without triggering any automation) by running 'bash ./start-solidity-qa-workflows.sh -h' or 'bash ./start-solidity-qa-workflows.sh --help'.

---->>>> Local Solidity Test Environment Setup Commands <<<<----
bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux
bash ./start-solidity-qa-workflows.sh Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux
bash ./start-solidity-qa-workflows.sh Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux
bash ./start-solidity-qa-workflows.sh Stop-All-Local-Network-Nodes-And-Delete-Logs-On-MacOS-Or-Linux"

---->>>> Solidity Static Analysis And Security Testing Commands <<<<----
bash ./start-solidity-qa-workflows.sh Run-Solidity-Static-Analysis
 
---->>>> Hardhat Deployment Commands Powered by Robot Framework RPA (NOTE: These scripts are capable of deploying to Mainnets or Testnets!) <<<<----
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Ethereum-RPA-Deployment
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Fantom-RPA-Deployment
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Polygon-RPA-Deployment
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Avalanche-RPA-Deployment

---->>>> Interactive Tests For Deployed Smart Contracts Using Hardhat (NOTE: These tests can run on multiple EVM Compatible Blockchains!) <<<<---- 
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Local-NonForked-Hardhat-Network
bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Forked-Mainnet-Hardhat-Network 
```
### Example Workflow 1 - Deploy then test a smart contract using the built-in Hardhat Network Ethereum Node and node-robotremoteserver (on MacOS or Linux)
From the commands posted above, here is an example workflow (with screenshots) below that will work reliably as long as both the basic technical requirements and the `bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux` command have been completed without issues.
- First, open two terminals and keep both open the entire time.
- In one of the terminals, run the `bash ./start-solidity-qa-workflows.sh Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux` command then check that the output matches what is shown in the following screenshot. 
![Part1](./notes-images-and-demonstrations/robotframework-hardhat-part1.png)
- In the other terminal, run the `bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Local-NonForked-Hardhat-Network` command then check that the output matches what is shown in the following screenshot. 
![Part2](./notes-images-and-demonstrations/robotframework-hardhat-part2.png)

### Example Workflow 2 - Fork Fantom Mainnet, deploy, then test an existing smart contract using the Hardhat Network Fantom fork and node-robotremoteserver (on MacOS or Linux)
From the commands posted above, here is an example workflow (with screenshots) below that will work reliably as long as both the basic technical requirements and the `bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux` command have been completed without issues.
- First, open two terminals and keep both open the entire time.
- In one of the terminals, run the `bash ./start-solidity-qa-workflows.sh Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux` command, follow the instructions by entering `Fantom`, then check that the output matches what is circled in the following screenshot. 
![Part3](./notes-images-and-demonstrations/robotframework-hardhat-part3.png)
- In the other terminal, run the `bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Forked-Mainnet-Hardhat-Network` command then check that the output matches what is circled in the following screenshot. 
![Part4](./notes-images-and-demonstrations/robotframework-hardhat-part4.png)
- This test will interact with someone else's existing token project (**contract address**: `0x5FbDB2315678afecb367f032d93F642f64180aa3`) on Fantom Mainnet called ["PumpNoDump (PND)"](https://ftmscan.com/address/0x5fbdb2315678afecb367f032d93f642f64180aa3). **FYI, the PND token is NOT mine and I am not associated with it at all.**
![Part5](./notes-images-and-demonstrations/robotframework-hardhat-part5.png)

### Example Workflow 3 - Use Robot Framework RPA to do only the deployment using Hardhat (on MacOS or Linux)
From the commands posted above, here is an example workflow below that will work reliably as long as both the basic technical requirements and the `bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux` command have been completed without issues.
- Only one terminal is needed.
- Run the `bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Ethereum-RPA-Deployment` command then check that the output matches what is shown in the following screenshot. 
![Part6](./notes-images-and-demonstrations/robotframework-hardhat-part6.png)

Results for the example workflows above can be found in the `...-log.html` files stored in the `logs` folder.

## Windows User Advice

All Windows users should please read my [NOTES.md](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/blob/main/notes-images-and-demonstrations/NOTES.md) file for more details.