*** Settings ***

Library           OperatingSystem
Library           Process
Library           String
Library           Collections

*** Variables ***

${ETHEREUM_INFURA_RPC_URL}    wss://mainnet.infura.io/ws/v3/<your-infura-api-key-goes-here>
${AVALANCHE_INFURA_RPC_URL}    wss://avalanche-mainnet.infura.io/ws/v3/<your-infura-api-key-goes-here>
${ETHERSCAN_BASE_URL}    https://etherscan.io/tx/
${SNOWTRACE_BASE_URL}    https://snowtrace.io/tx/

${RETRY_AMOUNT}    5
${RETRY_DELAY}    2

*** Tasks ***

ETHEREUM MAINNET - INFURA WEBSOCKET BOT TASK : Monitor the gas fee information of the 5 latest blocks on Ethereum Mainnet and log the metrics.
    [Tags]    Infura_Websocket_Bot_Task
    Monitor Gas Fee Information    ${ETHEREUM_INFURA_RPC_URL}

ETHEREUM MAINNET - INFURA WEBSOCKET BOT TASK : Monitor recently completed transactions on a recently created block on Ethereum Mainnet and log the 2 most recent.
    [Tags]    Infura_Websocket_Bot_Task
    Monitor Recent Blocks And Completed Transactions    ${ETHEREUM_INFURA_RPC_URL}

ETHEREUM MAINNET - INFURA WEBSOCKET BOT TASK : Monitor new pending transactions on the Ethereum Mainnet and log a list of transaction hashes from the Infura RPC URL.
    [Tags]    Infura_Websocket_Bot_Task
    Monitor New Pending Transactions    ${ETHEREUM_INFURA_RPC_URL}

ETHEREUM MAINNET - INFURA WEBSOCKET BOT TASK : Monitor new pending transactions on the Ethereum Mainnet and convert the hashes into Etherscan URLs.
    [Tags]    Infura_Websocket_Bot_Task
    Monitor Transactions And Log Blockchain Explorer Links    ${ETHEREUM_INFURA_RPC_URL}    ${ETHERSCAN_BASE_URL}

AVALANCHE MAINNET - INFURA WEBSOCKET BOT TASK : Monitor the gas fee information of the 5 latest blocks on Avalanche Mainnet and log the metrics.
    [Tags]    Infura_Websocket_Bot_Task
    Monitor Gas Fee Information    ${AVALANCHE_INFURA_RPC_URL}

AVALANCHE MAINNET - INFURA WEBSOCKET BOT TASK : Monitor recently completed transactions on a recently created block on Avalanche Mainnet and log the 2 most recent.
    [Tags]    Infura_Websocket_Bot_Task
    Monitor Recent Blocks And Completed Transactions    ${AVALANCHE_INFURA_RPC_URL}

###---> Un-comment the following tasks to see how differently the same JSON-RPC API methods of Avalanche behave compared to Ethereum's JSON-RPC API methods.
# AVALANCHE MAINNET - INFURA WEBSOCKET BOT TASK : Monitor new pending transactions on the Avalanche Mainnet and log a list of transaction hashes from the Infura RPC URL.
#     [Tags]    Infura_Websocket_Bot_Task
#     Monitor New Pending Transactions    ${AVALANCHE_INFURA_RPC_URL}

# AVALANCHE MAINNET - INFURA WEBSOCKET BOT TASK : Monitor new pending transactions on the Avalanche Mainnet and convert the hashes into Snowtrace URLs.
#     [Tags]    Infura_Websocket_Bot_Task
#     Monitor Transactions And Log Blockchain Explorer Links    ${AVALANCHE_INFURA_RPC_URL}    ${SNOWTRACE_BASE_URL}

*** Keywords ***

Monitor Gas Fee Information
    [Arguments]    ${INFURA_RPC_URL}
    Wait Until Keyword Succeeds    ${RETRY_AMOUNT} times    1 second    Get Gas Fee Information    ${INFURA_RPC_URL}

Get Gas Fee Information
    [Arguments]    ${INFURA_RPC_URL}
    Run    wscat -c ${INFURA_RPC_URL} -x '{"jsonrpc":"2.0","method":"eth_feeHistory","params":["0x5", "latest", []],"id":1}' | jq 'del(.result.oldestBlock)' > ${EXECDIR}/logs/eth_feeHistory.json
    ${INFURA_OUTPUT}=    Run    cat ${EXECDIR}/logs/eth_feeHistory.json
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${INFURA_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log    ${INFURA_OUTPUT}
    Should Not Be Empty    ${INFURA_OUTPUT}
    Sleep    ${RETRY_DELAY} seconds

Monitor Recent Blocks And Completed Transactions
    [Arguments]    ${INFURA_RPC_URL}
    Wait Until Keyword Succeeds    ${RETRY_AMOUNT} times    1 second    Get Recent Blocks And Completed Transactions    ${INFURA_RPC_URL}

Get Recent Blocks And Completed Transactions
    [Arguments]    ${INFURA_RPC_URL}
    Run    wscat -c ${INFURA_RPC_URL} -x '{"jsonrpc":"2.0","method":"eth_getBlockReceipts","params":["finalized"],"id":1}' | jq > ${EXECDIR}/logs/eth_getBlockReceipts.json
    ${INFURA_OUTPUT}=    Run    cat ${EXECDIR}/logs/eth_getBlockReceipts.json | jq .result[:2]
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${INFURA_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log    ${INFURA_OUTPUT}
    Should Not Be Empty    ${INFURA_OUTPUT}
    Sleep    ${RETRY_DELAY} seconds

Monitor New Pending Transactions
    [Arguments]    ${INFURA_RPC_URL}
    Wait Until Keyword Succeeds    ${RETRY_AMOUNT} times    1 second    Get New Pending Transactions    ${INFURA_RPC_URL}

Get New Pending Transactions
    [Arguments]    ${INFURA_RPC_URL}
    Run    wscat -c ${INFURA_RPC_URL} -x '{"jsonrpc":"2.0", "id": 1, "method": "eth_subscribe", "params": ["newPendingTransactions"]}' | jq .params.result | grep -v null > ${EXECDIR}/logs/eth_subscribe_newPendingTransactions.json
    ${INFURA_OUTPUT}=    Run    cat ${EXECDIR}/logs/eth_subscribe_newPendingTransactions.json
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${INFURA_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log    ${INFURA_OUTPUT}
    Should Not Be Empty    ${INFURA_OUTPUT}
    Sleep    ${RETRY_DELAY} seconds

Monitor Transactions And Log Blockchain Explorer Links
    [Arguments]    ${INFURA_RPC_URL}    ${BLOCKCHAIN_EXPLORER_BASE_URL}
    Wait Until Keyword Succeeds    ${RETRY_AMOUNT} times    1 second    Get Transactions And Log Blockchain Explorer Links    ${INFURA_RPC_URL}    ${BLOCKCHAIN_EXPLORER_BASE_URL}

Get Transactions And Log Blockchain Explorer Links
    [Arguments]    ${INFURA_RPC_URL}    ${BLOCKCHAIN_EXPLORER_BASE_URL}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Run Process    wscat -c ${INFURA_RPC_URL} -x '{"jsonrpc":"2.0", "id": 1, "method": "eth_subscribe", "params": ["newPendingTransactions"]}'    alias=infura_output    shell=True    timeout=20s    on_timeout=continue
    ${INFURA_OUTPUT}=    Get Process Result    infura_output    stdout=true
    Should Not Be Empty    ${INFURA_OUTPUT}
    Sleep    ${RETRY_DELAY} seconds
    @{transaction_hashes}=    Create List

    # Use Python's re module for more complicated regex handling
    ${transaction_hashes}=    Evaluate    re.findall(r'"result"\s*:\s*"0x[0-9a-fA-F]{64}"', """${INFURA_OUTPUT}""")    re

    # Extract just the transaction hashes from the matches, removing the `"result":"` from each match
    ${transaction_hashes}=    Evaluate    [match.split('"')[-2] for match in $transaction_hashes]

    # Create Etherscan URL links and log them
    FOR    ${tx_hash}    IN    @{transaction_hashes}
        ${etherscan_url}    Catenate    SEPARATOR=    ${BLOCKCHAIN_EXPLORER_BASE_URL}    ${tx_hash}
        Log To Console    ${etherscan_url}
        Log    ${etherscan_url}
    END
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...