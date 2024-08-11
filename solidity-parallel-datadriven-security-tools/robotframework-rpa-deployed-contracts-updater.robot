*** Settings ***
Library                   ${EXECDIR}/resources/SolidityCommentRemoverLibrary.py
Library                   OperatingSystem
Library                   Process
Library                   String
Library     DataDriver    ${EXECDIR}/resources/datadriver-files/datadriver-blockchain-explorer-deployed-contracts.csv    dialect=unix
Test Template    Run Solidity File Updater Tasks

*** Variables ***

${TARGET_SOLIDITY_VERSION}   ^0.8.0

*** Tasks ***

SETUP TASKS - DATADRIVER SOLIDITY FILE UPDATER : Update the contract ${CONTRACT_NAME} to have the same Solidity version as the other files.

*** Keywords ***

Run Solidity File Updater Tasks
    [Arguments]    ${CONTRACT_NAME}
    Update Solidity Version    ${CONTRACT_NAME}    pragma solidity \\^0\\.\\d+\\.\\d+;
    Update Solidity Version    ${CONTRACT_NAME}    pragma solidity 0\\.\\d+\\.\\d+;
    Remove Multi Line Comments From Solidity File    ${CONTRACT_NAME}
    Remove Single Line Comments From Solidity File    ${CONTRACT_NAME}

Remove Multi Line Comments From Solidity File
    [Arguments]    ${CONTRACT_NAME}
    Remove Multi Line Solidity Comments    ${EXECDIR}/resources/downloaded-contracts-in-docker/${CONTRACT_NAME}

Remove Single Line Comments From Solidity File
    [Arguments]    ${CONTRACT_NAME}
    Remove Single Line Solidity Comments    ${EXECDIR}/resources/downloaded-contracts-in-docker/${CONTRACT_NAME}

Update Solidity Version
    [Arguments]    ${CONTRACT_NAME}    ${REGEXP_PATTERN}
    ${OLD_FILE_CONTENT}=    Get File    ${EXECDIR}/resources/downloaded-contracts-in-docker/${CONTRACT_NAME}
    ${NEW_FILE_CONTENT}=    Replace String Using Regexp    ${OLD_FILE_CONTENT}    ${REGEXP_PATTERN}    pragma solidity ${TARGET_SOLIDITY_VERSION};
    Create File    ${EXECDIR}/resources/downloaded-contracts-in-docker/${CONTRACT_NAME}   ${NEW_FILE_CONTENT}
