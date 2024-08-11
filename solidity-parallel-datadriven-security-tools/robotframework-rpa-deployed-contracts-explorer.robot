*** Settings ***
Library                   ${EXECDIR}/resources/MultichainExplorerLibrary.py
Library                   OperatingSystem
Library                   Process
Library                   String
Library     DataDriver    ${EXECDIR}/resources/datadriver-files/datadriver-blockchain-explorer-deployed-contracts.csv    dialect=unix
Test Template    Run Multichain Explorer Tasks

*** Tasks ***

SETUP TASKS - DATADRIVER BLOCKCHAIN EXPLORER : Get verified smart contracts for address ${CONTRACT_ADDRESS} and log the contract information from the ${EXPLORER_URL} Mainnet blockchain explorer.

*** Keywords ***

Run Multichain Explorer Tasks
    [Arguments]    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}   ${CONTRACT_NAME}
    Download Contract Source Code    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}   ${CONTRACT_NAME}
    Get Contract Information    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}
    Setup Smart Contracts For Security Scanning Tools    ${CONTRACT_NAME}

Download Contract Source Code
    [Arguments]    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}   ${CONTRACT_NAME}
    Sleep    4 seconds     # <-- Time-delay to avoid blockchain explorer rate limit.
    Download Deployed Contract From Explorer    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}   ${CONTRACT_NAME}

Get Contract Information
    [Arguments]    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}
    Sleep    4 seconds     # <-- Time-delay to avoid blockchain explorer rate limit.
    ${CONTRACT_INFORMATION}=    Get Contract Creation Information    ${NETWORK_TYPE}    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${EXPLORER_API_KEY}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${CONTRACT_INFORMATION}
    Log    ${CONTRACT_INFORMATION}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...

Setup Smart Contracts For Security Scanning Tools
    [Arguments]    ${CONTRACT_NAME}
    Remove Files    ${EXECDIR}/resources/mythril/*.log
    Remove Files    ${EXECDIR}/resources/napalm/*.log
    Remove Files    ${EXECDIR}/resources/downloaded-contracts-in-docker/*.sol
    Copy Files    ${EXECDIR}/downloaded-deployed-contracts/*.sol    ${EXECDIR}/resources/downloaded-contracts-in-docker