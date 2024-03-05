*** Settings ***
Library    Browser

*** Test Cases ***

Quickly test a wagmi Mock Wallet dApp connected to an Ethereum local fork using Foundry's Anvil tool.
    Open New Browser And Setup Test    2
    Take Screenshot    EMBED
    Click Through Wallet Features And Continue After Heading Check
    Take Screenshot    EMBED

*** Keywords ***

Open New Browser And Setup Test
    [Arguments]    ${TIMEOUT_DURATION}
    New Browser    chromium    headless=No
    New Page    http://localhost:3000
    Get Title    contains    App
    Set Browser Timeout    ${TIMEOUT_DURATION} seconds
    Reload
    Sleep    30 seconds

Click Through Wallet Features And Continue After Heading Check
    Get Text    button    *=    ETH
    Click    "0xf3…2266"
    Click    "Copy Address"
    Click    "Disconnect"
    Click    "Connect Wallet"
    Click    "Mock Wallet"
    Wait Until Keyword Succeeds   10 times    1 second        Check Mock Wallet Heading    10

Check Mock Wallet Heading
    [Arguments]    ${DELAY_DURATION}
    Get Element By Role    heading    name=9,999.9 ETH
    Sleep    ${DELAY_DURATION} seconds