*** Settings ***
Library                       Collections
Library                       OperatingSystem
Library                       Process
Library                       String

*** Variables ***

${PATH}    ${EXECDIR}

*** Test Cases ***

SMART CONTRACT TEST 1 : Run the Solhint static analysis tool on the target contract. If this fails, then there are possible code security issues or other risks.
    [Tags]    Contract_Smoke_Tests
    Run Solhint Solidity Static Analysis And Check Output    targetContract.sol

SMART CONTRACT TEST 2 : Run the Surya code property graph analysis tool on the target contract. If this fails, then there are possible code risks or vulnerabilities.
    [Tags]    Contract_Smoke_Tests
    Run Surya Solidity Graph Analysis And Check Output    targetContract.sol

SMART CONTRACT TEST 3 : Run the Truffle Compile command and check the output for errors.
    [Tags]    Contract_Smoke_Tests
    Run Truffle Solidity Compile Command And Check Output

SMART CONTRACT TEST 4 : Run the Truffle Migrate command and check the output for errors.
    [Tags]    Contract_Smoke_Tests
    Run Truffle Solidity Migrate Command And Check Output

*** Keywords ***

Run Solhint Solidity Static Analysis And Check Output
    [Arguments]    ${SMART_CONTRACT_FILE_NAME}
    Run Process    solhint -h && solhint ${PATH}/solidity-smart-contract-test-tools/contracts/${SMART_CONTRACT_FILE_NAME} --config ${PATH}/solidity-smart-contract-test-tools/test/.solhint.json    alias=solhint_output    shell=True    timeout=20s    on_timeout=continue
    ${SOLHINT_OUTPUT}=    Get Process Result    solhint_output    stdout=true
    ${SOLHINT_RESULT}=    Convert To String    ${SOLHINT_OUTPUT}
    Log    ${SOLHINT_RESULT}
    #Log To Console    ${SOLHINT_RESULT}
    Should Not Be Empty    ${SOLHINT_RESULT}
    Should Contain    ${SOLHINT_RESULT}    (0 errors,

Run Surya Solidity Graph Analysis And Check Output
    [Arguments]    ${SMART_CONTRACT_FILE_NAME}
    Run Process    surya graph ${PATH}/solidity-smart-contract-test-tools/contracts/${SMART_CONTRACT_FILE_NAME} --no-color    alias=surya_output   shell=True    timeout=20s    on_timeout=continue
    ${SURYA_OUTPUT}=    Get Process Result    surya_output    stdout=true
    ${SURYA_RESULT}=    Convert To String    ${SURYA_OUTPUT}
    Log    ${SURYA_RESULT}
    #Log To Console    ${SURYA_RESULT}
    Should Not Contain    ${SURYA_RESULT}    "red"

Run Truffle Solidity Compile Command And Check Output
    Run Process    cd ${PATH}/solidity-smart-contract-test-tools/ && truffle compile   alias=truffle_compile    shell=True
    ${TRUFFLE_COMPILE_OUTPUT}=    Get Process Result    truffle_compile    stdout=true
    ${TRUFFLE_COMPILE_RESULT}=    Convert To String    ${TRUFFLE_COMPILE_OUTPUT}
    Log    ${TRUFFLE_COMPILE_RESULT}
    Log To Console    ${TRUFFLE_COMPILE_RESULT}
    Should Not Contain    ${TRUFFLE_COMPILE_RESULT}    failed

Run Truffle Solidity Migrate Command And Check Output
    Run Process    cd ${PATH}/solidity-smart-contract-test-tools/ && truffle migrate   alias=truffle_migrate    shell=True
    ${TRUFFLE_MIGRATE_OUTPUT}=    Get Process Result    truffle_migrate    stdout=true
    ${TRUFFLE_MIGRATE_RESULT}=    Convert To String    ${TRUFFLE_MIGRATE_OUTPUT}
    Log    ${TRUFFLE_MIGRATE_RESULT}
    Log To Console    ${TRUFFLE_MIGRATE_RESULT}
    Should Not Contain    ${TRUFFLE_MIGRATE_RESULT}    failed
