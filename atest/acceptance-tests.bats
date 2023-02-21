#!/usr/bin/env bats

@test "Check the end-to-end behavior of the 'start-solidity-qa-workflows.sh' Bash script after it installs all of the required Solidity tools" {
    cd "$CURRENT_PATH"
    nohup bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux > "$CURRENT_PATH"/atest/acceptance-test-resources/tools-installer-runner.acceptance-test-log &
    sleep 5
    cat "$CURRENT_PATH"/atest/acceptance-test-resources/tools-installer-runner.acceptance-test-log | grep "This command will install all of the required Node.js packages"
}

@test "Check the end-to-end behavior of the 'start-solidity-qa-workflows.sh' Bash script after it runs Solidity static anaylsis tools" {
    cd "$CURRENT_PATH"
    bash ./start-solidity-qa-workflows.sh Run-Solidity-Static-Analysis > "$CURRENT_PATH"/atest/acceptance-test-resources/static-analysis-runner.acceptance-test-log
    cat "$CURRENT_PATH"/atest/acceptance-test-resources/static-analysis-runner.acceptance-test-log | grep "SMART CONTRACT STATIC ANALYSIS"
}

@test "Check the end-to-end behavior of the 'start-solidity-qa-workflows.sh' Bash script after it runs a Robot Framework RPA local Hardhat smart contract deployment" {
    cd "$CURRENT_PATH"
    bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Fantom-RPA-Deployment > "$CURRENT_PATH"/atest/acceptance-test-resources/robotframework-hardhat-rpa-fantom-deployment-runner.acceptance-test-log
    cat "$CURRENT_PATH"/atest/acceptance-test-resources/robotframework-hardhat-rpa-fantom-deployment-runner.acceptance-test-log | grep "run ended"
}

@test "Check the end-to-end behavior of the 'start-solidity-qa-workflows.sh' Bash script after it runs Robot Framework Hardhat Ethers.js tests" {
    cd "$CURRENT_PATH"
    bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Tests-Default-NonForked-Hardhat-Network > "$CURRENT_PATH"/atest/acceptance-test-resources/robotframework-hardhat-ethersjs-test-runner.acceptance-test-log
    cat "$CURRENT_PATH"/atest/acceptance-test-resources/robotframework-hardhat-ethersjs-test-runner.acceptance-test-log | grep "HARDHAT ETHERS.JS TEST 12"
    sleep 5
    ls -la "$CURRENT_PATH"/solidity-hardhat-multichain-tools/logs | grep "smart-contract-hardhat-Fantom-tests-output.xml"
}