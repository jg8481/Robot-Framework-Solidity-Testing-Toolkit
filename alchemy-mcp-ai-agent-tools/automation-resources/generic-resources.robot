*** Settings ***
Library                   ${EXECDIR}/alchemy-mcp-ai-agent-tools/automation-resources/AIAgentLibrary.py
Library                   OperatingSystem
Library                   Process
Library                   String

*** Variables ***
${RETRY}    3
${DELAY}    2
## Fallback value. The main suite normally overrides this. It is the per-call
## time limit (in seconds) enforced on every local Goose AI Agent invocation so
## a stalled local model can never hang the automation run.
${LLM_TIME_CONSTRAINT}    240

*** Keywords ***

Wait Until Local Goose Prompt Succeeds
    [Timeout]    30 minutes
    [Arguments]    ${GOOSE_AI_PROMPT}
    Wait Until Keyword Succeeds    ${RETRY} times    0.25 seconds    Run Local Goose Prompt And Check Output    ${GOOSE_AI_PROMPT}

Run Local Goose Prompt And Check Output
    [Arguments]    ${GOOSE_AI_PROMPT}
    Sleep    ${DELAY} seconds
    ${OUTPUT}=    Send Local AI Agent Prompt Message    ${GOOSE_AI_PROMPT}    ${LLM_TIME_CONSTRAINT}
    ## This local-only design uses the Alchemy MCP Server as a Goose stdio extension running through Ollama.
    ## The Docker and cloud-provider examples are intentionally not used here.
    ## https://block.github.io/goose/blog/2025/03/31/goose-benchmark/#technical-challenges-with-open-models
    ## https://block.github.io/goose/blog/2025/04/11/finetuning-toolshim/#some-examples-of-model-specific-quirks-wrt-tool-calling
    Should Not Contain    ${OUTPUT}    crates/goose/src/agents/truncate.rs
    Should Not Contain    ${OUTPUT}    goose::agents::truncate:
    Should Not Contain    ${OUTPUT}    Please retry if you think this is a transient or recoverable error.
    Should Not Contain Any    ${OUTPUT}    UNAVAILABLE    ERROR    Request failed    400 Bad Request    Server error    Ran into this error
    Should Not Contain Any    ${OUTPUT}    extension_name:    uri:    Tool not found
    Should Not Contain Any    ${OUTPUT}    platform    search_available_extensions    remember_memory
    Should Not Contain Any    ${OUTPUT}    。    、    大    澳    中    一    ·    文
    Set Suite Variable    ${OUTPUT}

Wait Until Local Goose Instruction File Succeeds
    [Timeout]    60 minutes
    [Arguments]    ${GOOSE_AI_PROMPT}
    Wait Until Keyword Succeeds    ${RETRY} times    0.25 seconds    Run Local Goose Instruction File Succeeds    ${GOOSE_AI_PROMPT}

Run Local Goose Instruction File Succeeds
    [Arguments]    ${GOOSE_AI_PROMPT}
    Sleep    ${DELAY} seconds
    ${OUTPUT}=    Send Local AI Agent Instruction File    ${GOOSE_AI_PROMPT}    ${LLM_TIME_CONSTRAINT}
    Should Not Contain    ${OUTPUT}    crates/goose/src/agents/truncate.rs
    Should Not Contain    ${OUTPUT}    goose::agents::truncate:
    Should Not Contain    ${OUTPUT}    Please retry if you think this is a transient or recoverable error.
    Should Not Contain Any    ${OUTPUT}    UNAVAILABLE    ERROR    Request failed    400 Bad Request    Server error    Ran into this error
    Should Not Contain Any    ${OUTPUT}    extension_name:    uri:    Tool not found
    Should Not Contain Any    ${OUTPUT}    platform    search_available_extensions    remember_memory
    Should Not Contain Any    ${OUTPUT}    。    、    大    澳    中    一    ·    文
    Set Suite Variable    ${OUTPUT}

Run Goose AI Based On Instruction Type
    [Arguments]    ${GOOSE_AI_PROMPT}    ${INSTRUCTION_TYPE}
    IF    "${INSTRUCTION_TYPE}" == "User_Prompt"
        Wait Until Local Goose Prompt Succeeds    ${GOOSE_AI_PROMPT}
    ELSE IF    "${INSTRUCTION_TYPE}" == "Markdown_File"
        Wait Until Local Goose Instruction File Succeeds    ${EXECDIR}/alchemy-mcp-ai-agent-tools/agent-instructions/detailed-instructions/${GOOSE_AI_PROMPT}
    END

Create Local Agent Report
    [Arguments]    ${REPORT_NUMBER}
    Create File    ${EXECDIR}/alchemy-mcp-ai-agent-tools/${AI_AGENT_OUTPUT_FOLDER}/alchemy-mcp-agent-report${REPORT_NUMBER}-${TIMESTAMP}.md    ${OUTPUT}
    Run    cat ${EXECDIR}/alchemy-mcp-ai-agent-tools/${AI_AGENT_OUTPUT_FOLDER}/alchemy-mcp-agent-report${REPORT_NUMBER}-${TIMESTAMP}.md | sed -E 's/\x1B\[[0-9;]*[mK]//g' > ${EXECDIR}/alchemy-mcp-ai-agent-tools/${AI_AGENT_OUTPUT_FOLDER}/filtered-report${REPORT_NUMBER}-${TIMESTAMP}.md
    Run    mv ${EXECDIR}/alchemy-mcp-ai-agent-tools/${AI_AGENT_OUTPUT_FOLDER}/filtered-report${REPORT_NUMBER}-${TIMESTAMP}.md ${EXECDIR}/alchemy-mcp-ai-agent-tools/${AI_AGENT_OUTPUT_FOLDER}/alchemy-mcp-agent-report${REPORT_NUMBER}-${TIMESTAMP}.md

Display Goose AI Logs
    Log to Console    ...
    Log to Console    ...
    Log to Console    ...
    Log to Console    ${OUTPUT}
    Log to Console    ...
    Log to Console    ...
    Log to Console    ...
    Log    ${OUTPUT}
