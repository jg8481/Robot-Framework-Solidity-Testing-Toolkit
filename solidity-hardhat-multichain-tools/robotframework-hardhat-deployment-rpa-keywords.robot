*** Settings ***
Library                       OperatingSystem
Library                       Process

*** Variables ***

${PATH}    ${EXECDIR}/solidity-hardhat-multichain-tools
${NETWORK}   hardhat ### This will deploy your smart contract to the local Hardhat Network Node
#${NETWORK}   rinkeby ### This will deploy your smart contract to the Ethereum Rinkeby Testnet. You need a wallet private key set to the provided Ethereum.config.js file, otherwise it won't work.
#${NETWORK}   goerli ### This will deploy your smart contract to the Ethereum Goerli Testnet. You need a wallet private key set to the provided Ethereum.config.js file, otherwise it won't work.

*** Tasks ***

DEPLOYMENT STEP 1 : Compile Solidity smart contracts using the "npx hardhat compile" command.
    Remove File    ${PATH}/logs/hardhat-contract-compile.log
    Run Process    cd ${PATH} && echo "..." > ./logs/hardhat-contract-compile.log && npx hardhat compile >> ./logs/hardhat-contract-compile.log    shell=yes
    ${OUTPUT}=    Get File    ${PATH}/logs/hardhat-contract-compile.log
    Log    ${OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Run Process    killall node && killall npm    shell=yes

DEPLOYMENT STEP 2 : Start a local JSON-RPC server node on top of Hardhat Network the "npx hardhat node" command, while forking the mainnet of a specific EVM compatible blockchain.
    Remove File    ${PATH}/logs/hardhat-${BLOCKCHAIN}-network-node.log
    Start Process    cd ${PATH} && echo "..." > ./logs/hardhat-${BLOCKCHAIN}-network-node.log && npx hardhat node --config ${BLOCKCHAIN}.config.js > ./logs/hardhat-${BLOCKCHAIN}-network-node.log &    shell=yes
    Sleep    10s
    ${OUTPUT}=    Get File    ${PATH}/logs/hardhat-${BLOCKCHAIN}-network-node.log
    Log    ${OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    This local Hardhat Network deployment ran a fork of the ${BLOCKCHAIN} mainnet.
    Log To Console    ${OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...

DEPLOYMENT STEP 3 : Deploy the compiled Solidity smart contracts to the local Hardhat Network node.
    Remove File    ${PATH}/logs/hardhat-contract-deployment.log
    Run Process    cd ${PATH} && echo "..." > ./logs/hardhat-contract-deployment.log && npx hardhat run --network ${NETWORK} ./scripts/deploy.js >> ./logs/hardhat-contract-deployment.log    shell=yes
    ${OUTPUT}=    Get File    ${PATH}/logs/hardhat-contract-deployment.log
    Log    ${OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
