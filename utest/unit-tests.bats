#!/usr/bin/env bats

@test "Check the Robot Framework Hardhat node-robotremoteserver status after starting the server" {
    cat ./unit-test-resources/robotframework-hardhat-remote-library-standalone-mode.unit-test-log | grep starting
}

@test "Check the Hardhat .robot file for keyword syntax issues" {
    robot --dryrun --report NONE --log NONE --output NONE "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/robot-dryrun.unit-test-log
}

@test "Check the Hardhat Get Contract keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 1 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-contract.unit-test-log
    cat ./unit-test-resources/test-get-contract.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Name keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 2 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-name.unit-test-log
    cat ./unit-test-resources/test-get-name.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Symbol keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 3 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-symbol.unit-test-log
    cat ./unit-test-resources/test-get-symbol.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Default Decimals keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 4 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-default-decimals.unit-test-log
    cat ./unit-test-resources/test-get-default-decimals.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Total Supply keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 5 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-total-supply.unit-test-log
    cat ./unit-test-resources/test-get-total-supply.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Token Balance Address keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 6 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-token-balance-address.unit-test-log
    cat ./unit-test-resources/test-get-token-balance-address.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Receiver Target Address and Transfer To Target Address keywords using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 7 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-transfer-to-target-address.unit-test-log
    cat ./unit-test-resources/test-transfer-to-target-address.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Balance Of Address keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 8 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-get-balance-of-address.unit-test-log
    cat ./unit-test-resources/test-get-balance-of-address.unit-test-log | grep HH700
}

@test "Check the Hardhat Approve Spender Amount and Show Spender Allowance keywords using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 9 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-approve-spender-amount.unit-test-log
    cat ./unit-test-resources/test-approve-spender-amount.unit-test-log | grep HH700
}

@test "Check the Hardhat Get Token Balance Address, Get Receiver Target Address, and Transfer From Target Address keywords using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 10 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-transfer-from-target-address.unit-test-log
    cat ./unit-test-resources/test-transfer-from-target-address.unit-test-log | grep HH700
}

@test "Check the Hardhat Increase Spender Allowance keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 11 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-increase-spender-allowance.unit-test-log
    cat ./unit-test-resources/test-increase-spender-allowance.unit-test-log | grep HH700
}

@test "Check the Hardhat Decrease Spender Allowance keyword using just the .robot file and the node-robotremoteserver" {
    robot --nostatusrc --report NONE --log NONE --output NONE --test "HARDHAT ETHERS.JS TEST 12 :*" "$CURRENT_PATH"/solidity-hardhat-multichain-tools/robotframework-hardhat-test-keywords.robot > "$CURRENT_PATH"/utest/unit-test-resources/test-decrease-spender-allowance.unit-test-log
    cat ./unit-test-resources/test-decrease-spender-allowance.unit-test-log | grep HH700
}