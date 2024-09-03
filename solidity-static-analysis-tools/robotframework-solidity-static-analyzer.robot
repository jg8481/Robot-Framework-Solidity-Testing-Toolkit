*** Settings ***
Library                       Collections
Library                       OperatingSystem
Library                       Process
Library                       String

*** Variables ***

${PATH}    ${EXECDIR}

*** Test Cases ***

SMART CONTRACT STATIC ANALYSIS 1 : Run the Solhint static analysis tool on the target contract. If this fails, then there are possible code security issues or other risks.
    [Tags]    Contract_Smoke_Tests
    Run Solhint Solidity Static Analysis And Check Output    TargetContract.sol

SMART CONTRACT STATIC ANALYSIS 2 : Run the Surya code property graph analysis tool on the target contract. If this fails, then there are possible code risks or vulnerabilities.
    [Tags]    Contract_Smoke_Tests
    Run Surya Solidity Graph Analysis And Check Output    TargetContract.sol

*** Keywords ***

Run Solhint Solidity Static Analysis And Check Output
    [Arguments]    ${SMART_CONTRACT_FILE_NAME}
    Run Process    solhint ${PATH}/contracts/${SMART_CONTRACT_FILE_NAME} --config ${PATH}/.solhint.json    alias=solhint_output    shell=True    timeout=20s    on_timeout=continue
    ${SOLHINT_OUTPUT}=    Get Process Result    solhint_output    stdout=true
    ${SOLHINT_RESULT}=    Convert To String    ${SOLHINT_OUTPUT}
    Log    ${SOLHINT_RESULT}
    #Log To Console    ${SOLHINT_RESULT}
    Should Not Be Empty    ${SOLHINT_RESULT}
    Should Contain    ${SOLHINT_RESULT}    (0 errors,

Run Surya Solidity Graph Analysis And Check Output
    [Arguments]    ${SMART_CONTRACT_FILE_NAME}
    Run Process    surya graph ${PATH}/solidity-static-analysis-tools/contracts/${SMART_CONTRACT_FILE_NAME} --no-color    alias=surya_output   shell=True    timeout=20s    on_timeout=continue
    ${SURYA_OUTPUT}=    Get Process Result    surya_output    stdout=true
    ${SURYA_RESULT}=    Convert To String    ${SURYA_OUTPUT}
    Log    ${SURYA_RESULT}
    #Log To Console    ${SURYA_RESULT}
    Should Not Contain    ${SURYA_RESULT}    "red"
