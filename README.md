# Robot Framework Solidity Testing Toolkit

## General Information

This toolkit contains automation that helps check BEP-20 or ERC-20 smart contracts written in Solidity. A lot of the automation in this repo is heavily influenced by my [Robot-Framework-Lone-Tester-Strategies-RoboCon-2019](https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019) and [Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019) workshops. More information about these RoboCon workshops can be found here... https://robocon.io/#workshops

The following are the basic technical requirements needed to run these automated checks.
- Python 3 -> https://www.python.org/downloads/
- NodeJS -> https://nodejs.org/en/ or use https://github.com/nvm-sh/nvm
- Robot Framework -> https://robotframework.org
- Truffle -> http://trufflesuite.com/docs/truffle/quickstart.html
- Ganache -> https://trufflesuite.com/ganache/

## Quick Start Guide

Before running any of the automation first make sure that Ganache is running. After starting Ganache run the following commands.
```
bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS
bash ./start-solidity-qa-workflows.sh Run-Solidity-QA-Checks
```

Results for each automation run can be found in the `smart-contract-testing-log.html` file.