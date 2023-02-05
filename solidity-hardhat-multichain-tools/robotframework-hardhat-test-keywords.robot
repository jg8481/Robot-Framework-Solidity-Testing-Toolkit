*** Settings ***
Library    Remote    http://localhost:${REMOTE_LIBRARY_PORT}

*** Variables ***
${REMOTE_LIBRARY_PORT}    8270

*** Test Cases ***

Get the deployed smart contract using the hardhat-ethers plugin object and check the result.
    [Tags]    Forked_Mainnet_Test
    ${RESULT}=    Get Contract
    Should Not Contain    ${RESULT}    errorName

Get token name from the the deployed smart contract and check the result.
    ${RESULT}=    Get Name
    Check Smart Contract Results And Log Them    ${RESULT}    name

Get token symbol from the the deployed smart contract and check the result.
    ${RESULT}=    Get Symbol
    Check Smart Contract Results And Log Them    ${RESULT}    symbol

Get the decimals from the the deployed smart contract and check the result.
    ${RESULT}=    Get Default Decimals
    Check Smart Contract Results And Log Them    ${RESULT}    decimals

Get total token supply from the the deployed smart contract and check the result.
    ${RESULT}=    Get Total Supply
    Check Smart Contract Results And Log Them    ${RESULT}    totalSupplyFormatUnits

Get balance of tokens from the address of the deployed smart contract owner and check the result.
    ${TOKEN_ADDRESS}=    Get Token Balance Address
    Check Smart Contract Results And Log Them    ${TOKEN_ADDRESS}   testTokenAddress
    ${RESULT}=    Get Balance Of Address
    Check Smart Contract Results And Log Them    ${RESULT}   addressBalance

Transfer tokens to a target address from the contract owner address and check the result.
    ${RECEIVING_ADDRESS}=    Get Receiver Target Address
    Check Smart Contract Results And Log Them    ${RECEIVING_ADDRESS}    receivingAddress
    ${RESULT}=    Transfer To Target Address
    Check Smart Contract Results And Log Them    ${RESULT}    receiverBalanceFormatUnits

Get balance of tokens from the address of the deployed smart contract owner after sending tokens to another address and check the result.
    ${RESULT}=    Get Balance Of Address
    Check Smart Contract Results And Log Them    ${RESULT}    addressBalance

Approve a specific amount of tokens for a target address, show the allowance, and check the result.
    ${APPROVAL_OUTPUT}=    Approve Spender Amount
    Check Smart Contract Results And Log Them    ${APPROVAL_OUTPUT}    approvalSuccess
    ${RESULT}=    Show Spender Allowance
    Check Smart Contract Results And Log Them    ${RESULT}    showAllowance

Transfer tokens from a target address to the contract owner address and check the result.
    ${TOKEN_ADDRESS}=    Get Token Balance Address
    Check Smart Contract Results And Log Them    ${TOKEN_ADDRESS}   testTokenAddress
    ${RECEIVING_ADDRESS}=    Get Receiver Target Address
    Check Smart Contract Results And Log Them    ${RECEIVING_ADDRESS}    receivingAddress
    ${RESULT}=    Transfer From Target Address
    Check Smart Contract Results And Log Them    ${RESULT}    senderBalanceFormatUnits

Increase the allowance of the spender account and check the result.
    ${RESULT}=    Increase Spender Allowance
    Check Smart Contract Results And Log Them    ${RESULT}    showIncreasedAllowance

Decrease the allowance of the spender account and check the result.
    ${RESULT}=    Decrease Spender Allowance
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


