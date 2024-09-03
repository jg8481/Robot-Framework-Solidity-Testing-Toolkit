*** Settings ***

Library    Remote    http://localhost:${REMOTE_LIBRARY_PORT}

*** Variables ***

${REMOTE_LIBRARY_PORT}    8270

*** Tasks ***

ALCHEMY SDK BOT TASK : Get the current total amount of NFTs owned by Vitalik Buterin from Ethereum Mainnet.
    [Tags]    Alchemy_SDK_Bot_Task
    ${RESULT}=    Get NFT Owner Information
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${RESULT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...

ALCHEMY SDK BOT TASK : Get the current metadata about a specific NFT from Ethereum Mainnet.
    [Tags]    Alchemy_SDK_Bot_Task
    ${RESULT}=    Get NFT Metadata
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${RESULT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
