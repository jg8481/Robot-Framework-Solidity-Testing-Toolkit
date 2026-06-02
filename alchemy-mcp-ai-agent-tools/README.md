# Alchemy MCP AI Agent Tools

A fully local Robot Framework + DataDriver workflow that runs the Alchemy MCP Server's
["Example Prompts"](https://github.com/alchemyplatform/alchemy-mcp-server#example-prompts) through a
[Codename Goose](https://block.github.io/goose/) AI Agent powered by a **local Ollama model**.

This folder mirrors the design of `Robot-Framework-AI-Agent-Datadriver`, but every prompt is handled
by the **local Goose CLI on this machine** (no cloud LLM providers). Goose
reaches Alchemy's blockchain APIs through the Alchemy MCP Server, which is registered as a Goose
`stdio` extension in `automation-resources/config.yaml`.

The prompts are driven from a [robotframework-datadriver](https://github.com/Snooz82/robotframework-datadriver)
CSV file (`agent-instructions/alchemy-mcp-example-prompts.csv`) and filtered with Robot Framework tags.

---

## 1. Technical requirements

Install these once before running anything. Everything below was built and tested on macOS, but it
also works on Linux.

- **Homebrew** (macOS) -> https://brew.sh/
- **Python 3** -> https://www.python.org/downloads/
- **Node.js + npm** (used to build the local Alchemy MCP Server) -> https://nodejs.org/
- **Ollama** (local LLM runtime) -> https://ollama.com/download
- **Codename Goose** (AI agent CLI) -> https://block.github.io/goose/docs/getting-started/installation
- **An Alchemy API key** (free) -> https://www.alchemy.com/

> The `Get-Codename-Goose-AI-Agent-And-Build-Alchemy-MCP-Server` command below will install Ollama,
> the Goose CLI, pull the default `mistral` model, and build the local Alchemy MCP Server for you.
> You still need Homebrew, Python 3, Node.js/npm, and an Alchemy API key in place first.

### Folder layout this workflow expects

The build step copies and compiles the Alchemy MCP Server from `alchemy-mcp-server-main`. Keep that
folder either **next to** the toolkit folder (recommended) or **inside** it:

```
Robot-Framework-Solidity-Testing-Toolkit_AI_Enhancements_2026/
├── alchemy-mcp-server-main/                      <-- the Alchemy MCP Server source
└── Robot-Framework-Solidity-Testing-Toolkit-main/
    ├── start-solidity-qa-workflows.sh            <-- run all commands from here
    └── alchemy-mcp-ai-agent-tools/               <-- this folder
```

---

## 2. One-time setup

Run all commands from the toolkit root (the folder that contains `start-solidity-qa-workflows.sh`):

```bash
cd /path/to/Robot-Framework-Solidity-Testing-Toolkit-main
```

Install Goose + Ollama, pull the default model, and build the local Alchemy MCP Server:

```bash
bash ./start-solidity-qa-workflows.sh Get-Codename-Goose-AI-Agent-And-Build-Alchemy-MCP-Server
```

This command:

1. Installs Ollama (`brew install ollama`) and starts it as a service.
2. Installs the Codename Goose CLI.
3. Pulls the default `mistral` model used by `automation-resources/config.yaml`.
4. Copies `alchemy-mcp-server-main` into `alchemy-mcp-ai-agent-tools/alchemy-mcp-server`, then runs
   `npm install` and `npm run build` to produce `alchemy-mcp-server/dist/index.js`.

> Want a different model (for example `qwen3`)? Run `ollama pull qwen3` and change the `GOOSE_MODEL`
> value in `alchemy-mcp-ai-agent-tools/automation-resources/config.yaml` to match.

---

## 3. Provide your Alchemy API key

The Alchemy MCP Server needs an API key for live blockchain data. Export it in the **same terminal
session** you will use to run the tasks:

```bash
export ALCHEMY_API_KEY=your_real_alchemy_api_key_here
```

The run command reads this environment variable and injects it (along with the local MCP server path)
into the active Goose config at `~/.config/goose/config.yaml`. If the variable is missing, you will
get a warning and the Alchemy tools will not return live data.

---

## 4. Run the datadriven Alchemy MCP prompts

General form (the tag selects which prompts run):

```bash
bash ./start-solidity-qa-workflows.sh Run-Datadriven-Alchemy-MCP-Local-AI-Tasks <ROBOT_FRAMEWORK_TAG>
```

Examples:

```bash
# Run only the token-price prompt
bash ./start-solidity-qa-workflows.sh Run-Datadriven-Alchemy-MCP-Local-AI-Tasks Prices

# Run all three price-history prompts
bash ./start-solidity-qa-workflows.sh Run-Datadriven-Alchemy-MCP-Local-AI-Tasks PriceHistory

# Combine tags with Robot Framework tag logic (OR / AND / NOT)
bash ./start-solidity-qa-workflows.sh Run-Datadriven-Alchemy-MCP-Local-AI-Tasks PriceHistoryORTokens
```

### Available tags (mapped to the Alchemy "Example Prompts")

| Tag            | Prompt |
| -------------- | ------ |
| `Prices`       | What is the current price of Bitcoin and Ethereum? |
| `NFTs`         | Show me the NFTs owned by the wallet 0x1234...5678 on Ethereum. |
| `Tokens`       | What tokens does wallet 0xabcd...6789 hold across Ethereum and Base? |
| `Transactions` | Get me the transaction history for 0x9876...5432. |
| `PriceHistory` | Ethereum price history (daily), Bitcoin last week (hourly), ETH past month. |
| `Transfers`    | What ERC-20 transfers happened to 0x1234...5678 in the last 100 blocks? |

> The example prompts use placeholder wallet addresses (e.g. `0x1234...5678`) exactly as published in
> the Alchemy README. Replace them with real addresses in
> `agent-instructions/alchemy-mcp-example-prompts.csv` to query live wallet data.

What the run command does:

1. Stops any leftover `goose`/`ollama` processes.
2. Regenerates `~/.config/goose/config.yaml` from this folder's template, injecting your
   `ALCHEMY_API_KEY` and the built MCP server path.
3. Starts Ollama and creates a Python virtualenv, installing `automation-resources/requirements.txt`.
4. Runs `robotframework-alchemy-mcp-local-ai-agent.robot` with `--variable INCLUDED_TAG:<TAG>`.
5. Stops `goose`/`ollama` when finished.

---

## 5. Where to find the results

- **Per-prompt agent reports (Markdown):**
  `alchemy-mcp-ai-agent-tools/automation-resources/ai-agent-output-collector/ai-agent-output/alchemy-mcp-agent-report<N>-<TIMESTAMP>.md`
- **Robot Framework log/output:**
  `alchemy-mcp-ai-agent-tools/logs/robotframework-alchemy-mcp-local-ai-agent-log.html`
  and `...-output.xml`
- **Ollama status snapshot:**
  `alchemy-mcp-ai-agent-tools/automation-resources/ai-agent-output-collector/ollama-output.log`

---

## 6. See all available commands

```bash
bash ./start-solidity-qa-workflows.sh -h
```

---

## 7. Troubleshooting

- **"The local Alchemy MCP Server build was not found"** — run the
  `Get-Codename-Goose-AI-Agent-And-Build-Alchemy-MCP-Server` command first, and confirm
  `alchemy-mcp-ai-agent-tools/alchemy-mcp-server/dist/index.js` exists.
- **"Could not find the alchemy-mcp-server-main folder"** — place `alchemy-mcp-server-main` next to
  (or inside) the toolkit folder, then re-run the build command.
- **"ALCHEMY_API_KEY environment variable is not set"** — `export ALCHEMY_API_KEY=...` in the same
  terminal before running the tasks.
- **Ollama warnings / no `NAME` listed** — confirm Ollama is installed and that you pulled a model
  (`ollama pull mistral`). See https://block.github.io/goose/docs/getting-started/providers#local-llms-ollama
- **Model quirks with tool calling** — open models vary in MCP tool-calling reliability. If a prompt
  stalls, try a different model (e.g. `qwen3`) and update `GOOSE_MODEL` in `config.yaml`.
