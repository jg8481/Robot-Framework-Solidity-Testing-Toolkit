*** Settings ***
Library                   OperatingSystem
Library                   Process
Library     DataDriver    ${EXECDIR}/resources/datadriver-files/datadriver-downloaded-deployed-contracts.csv    dialect=unix
Test Template    Run Mythril Docker Container Vulnerability Scan


*** Variables ***

${HOST_MACHINE_RESOURCE_PATH}    ${EXECDIR}/resources

*** Test Cases ***

TEST : Get verified smart contracts for address ${CONTRACT_ADDRESS} and log the contract information from the ${EXPLORER_URL} Mainnet blockchain explorer. Then run the Consensys Mythril security analysis tool to check for Solidity vulnerabilities using EVM bytecode.

*** Keywords ***

Run Mythril Docker Container Vulnerability Scan
    [Arguments]    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${DOCKER_FILE_PATH}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    General information about the contract that will be scanned for vulnerabilities in a Docker Container.
    Log To Console    ${EXPLORER_URL} >>> ${CONTRACT_ADDRESS} >>> ${DOCKER_FILE_PATH}
    Log    ${EXPLORER_URL} >>> ${CONTRACT_ADDRESS} >>> ${DOCKER_FILE_PATH}
    Run    ${HOST_MACHINE_RESOURCE_PATH}/run-solidity-security-tests.sh Run-Consensys-Mythril-In-Docker-Using-Robot-Framework ${HOST_MACHINE_RESOURCE_PATH} ${DOCKER_FILE_PATH} ${EXPLORER_URL} ${CONTRACT_ADDRESS}
    Sleep    4 seconds
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Check Mythril Vulnerability Analysis Results    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}

Check Mythril Vulnerability Analysis Results
    [Arguments]    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    Checking the results of the Consensys Mythril security analysis tool for EVM bytecode.
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    ${MYTHRIL_OUTPUT}=    Get File   ${HOST_MACHINE_RESOURCE_PATH}/mythril/${EXPLORER_URL}-${CONTRACT_ADDRESS}-mythril-output.log
    Log    ${MYTHRIL_OUTPUT}
    Should Not Contain    ${MYTHRIL_OUTPUT}    Severity