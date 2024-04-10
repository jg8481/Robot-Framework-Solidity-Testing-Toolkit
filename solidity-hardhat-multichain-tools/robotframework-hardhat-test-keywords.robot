*** Settings ***
Library    Remote    http://localhost:${REMOTE_LIBRARY_PORT}

*** Variables ***
${REMOTE_LIBRARY_PORT}    8270

*** Test Cases ***

HARDHAT ETHERS.JS TEST 1 : Get the deployed smart contract using the hardhat-ethers plugin object and check the result.
    [Tags]    Forked_Mainnet_Test
    ${RESULT}=    Get Contract    %{CONTRACT_ADDRESS}
    Should Not Contain    ${RESULT}    errorName

HARDHAT ETHERS.JS TEST 2 : Get token name from the deployed smart contract and check the result.
    ${RESULT}=    Get Name    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    name

HARDHAT ETHERS.JS TEST 3 : Get token symbol from the deployed smart contract and check the result.
    ${RESULT}=    Get Symbol    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    symbol

HARDHAT ETHERS.JS TEST 4 : Get the decimals from the deployed smart contract and check the result.
    ${RESULT}=    Get Default Decimals    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    decimals

HARDHAT ETHERS.JS TEST 5 : Get total token supply from the deployed smart contract and check the result.
    ${RESULT}=    Get Total Supply    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    totalSupplyFormatUnits

HARDHAT ETHERS.JS TEST 6 : Get balance of tokens from the address of the deployed smart contract owner and check the result.
    ${TOKEN_ADDRESS}=    Get Token Balance Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${TOKEN_ADDRESS}   testTokenAddress
    ${RESULT}=    Get Balance Of Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}   addressBalance

HARDHAT ETHERS.JS TEST 7 : Transfer tokens to a target address from the contract owner address and check the result.
    ${RECEIVING_ADDRESS}=    Get Receiver Target Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RECEIVING_ADDRESS}    receivingAddress
    ${RESULT}=    Transfer To Target Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    receiverBalanceFormatUnits

HARDHAT ETHERS.JS TEST 8 : Get balance of tokens from the address of the deployed smart contract owner after sending tokens to another address and check the result.
    ${RESULT}=    Get Balance Of Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    addressBalance

HARDHAT ETHERS.JS TEST 9 : Approve a specific amount of tokens for a target address, show the allowance, and check the result.
    ${APPROVAL_OUTPUT}=    Approve Spender Amount    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${APPROVAL_OUTPUT}    approvalSuccess
    ${RESULT}=    Show Spender Allowance    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    showAllowance

HARDHAT ETHERS.JS TEST 10 : Transfer tokens from a target address to the contract owner address and check the result.
    ${TOKEN_ADDRESS}=    Get Token Balance Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${TOKEN_ADDRESS}   testTokenAddress
    ${RECEIVING_ADDRESS}=    Get Receiver Target Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RECEIVING_ADDRESS}    receivingAddress
    ${RESULT}=    Transfer From Target Address    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    senderBalanceFormatUnits

HARDHAT ETHERS.JS TEST 11 : Increase the allowance of the spender account and check the result.
    ${RESULT}=    Increase Spender Allowance    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    showIncreasedAllowance

HARDHAT ETHERS.JS TEST 12 : Decrease the allowance of the spender account and check the result.
    ${RESULT}=    Decrease Spender Allowance    %{CONTRACT_ADDRESS}
    Check Smart Contract Results And Log Them    ${RESULT}    showDecreasedAllowance

*** Keywords ***

Check Smart Contract Results And Log Them
    [Arguments]    ${HARDHAT_OUTPUT}    ${HARDHAT_CHECK}
    Log    ${HARDHAT_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${HARDHAT_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Should Not Be Empty    ${HARDHAT_OUTPUT}
    Should Not Contain    ${HARDHAT_OUTPUT}    Error
    Should Contain    ${HARDHAT_OUTPUT}    ${HARDHAT_CHECK}


