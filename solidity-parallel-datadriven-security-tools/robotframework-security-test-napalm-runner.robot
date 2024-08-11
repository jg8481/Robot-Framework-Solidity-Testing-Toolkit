*** Settings ***
Library                   OperatingSystem
Library                   Process
Library     DataDriver    ${EXECDIR}/resources/datadriver-files/datadriver-downloaded-deployed-contracts.csv    dialect=unix
Test Template    Run Napalm Docker Container Vulnerability Scan


*** Variables ***

${HOST_MACHINE_RESOURCE_PATH}    ${EXECDIR}/resources

*** Test Cases ***

TEST : Get verified smart contracts for address ${CONTRACT_ADDRESS} and log the contract information from the ${EXPLORER_URL} Mainnet blockchain explorer. Then run the Consensys Napalm static analysis tool to check for Solidity vulnerabilities.

*** Keywords ***

Run Napalm Docker Container Vulnerability Scan
    [Arguments]    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}    ${DOCKER_FILE_PATH}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    General information about the contract that will be scanned for vulnerabilities in a Docker Container.
    Log To Console    ${EXPLORER_URL} >>> ${CONTRACT_ADDRESS} >>> ${DOCKER_FILE_PATH}
    Log    ${EXPLORER_URL} >>> ${CONTRACT_ADDRESS} >>> ${DOCKER_FILE_PATH}
    Run    ${HOST_MACHINE_RESOURCE_PATH}/run-solidity-security-tests.sh Run-Consensys-Napalm-In-Docker-Using-Robot-Framework ${DOCKER_FILE_PATH} ${EXPLORER_URL} ${CONTRACT_ADDRESS}
    Sleep    4 seconds
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Check Napalm Vulnerability Analysis Results    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}

Check Napalm Vulnerability Analysis Results
    [Arguments]    ${EXPLORER_URL}    ${CONTRACT_ADDRESS}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    Checking the results of the Consensys Napalm security analysis tool for Solidity code.
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    ${NAPALM_OUTPUT}=    Get File   ${HOST_MACHINE_RESOURCE_PATH}/napalm/${EXPLORER_URL}-${CONTRACT_ADDRESS}-napalm-output.log
    Log    ${NAPALM_OUTPUT}
    Should Not Contain    ${NAPALM_OUTPUT}    Warning