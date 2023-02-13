#! /bin/bash

clear
TIMESTAMP=$(date)

if [ "$1" == "Stop-All-Local-Network-Nodes-And-Delete-Logs-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Stop-All-Local-Network-Nodes-And-Delete-Logs-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command will stop any locally running network nodes and clean up any logs leftover from old runs. Feel free to run this command multiple times to clean up files listed below. This run started on $TIMESTAMP."
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  rm -rf ./solidity-hardhat-multichain-tools/logs/*.log
  rm -rf ./solidity-truffle-web3js-tools/logs/*.log
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Install-Tools-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Install-Tools-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command will install all of the required Node.js packages. The current LTS Node.js version is 18. This run started on $TIMESTAMP."
  echo
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash &&
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install 18
  nvm use 18
  nvm alias default 18
  npm install npm --global 
  npm install -g solhint
  npm install -g solgraph
  npm install -g surya
  npm install --save-dev hardhat
  npm install --save-dev @nomicfoundation/hardhat-toolbox
  npm install -g truffle
  npm install @truffle/contract
  npm install web3
  npm install robotremote
  npm update
  npm audit fix --force
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit 0
fi

if [ "$1" == "Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command was designed to run a built-in Hardhat Network locally running Ethereum node in its own terminal window. It will also start the node-robotremoteserver. This run started on $TIMESTAMP."
  echo
  echo "Please read this documentation to learn more about the Hardhat Network tool... https://hardhat.org/hardhat-network/docs/overview"
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  cd ./solidity-hardhat-multichain-tools
  rm -rf ./logs/hardhat-default-network-node-standalone-mode.log
  rm -rf ./logs/robotframework-hardhat-remote-library-standalone-mode.log
  rm -rf ./logs/hardhat-contract-compile.log
  echo "Ethereum" > ./logs/blockchain-type.log
  echo
  echo
  npx hardhat compile > ./logs/hardhat-contract-compile.log &&
  echo
  echo
  npx hardhat node > ./logs/hardhat-default-network-node-standalone-mode.log &
  sleep 10
  echo
  echo
  npx hardhat run --network localhost ./scripts/deploy.js >> ./logs/hardhat-contract-deployment-standalone-mode.log &&
  echo
  echo
  export HARDHAT_NETWORK=localhost && nohup node ./robotframework-hardhat-remote-library.js > ./logs/robotframework-hardhat-remote-library-standalone-mode.log &
  sleep 10
  TIMESTAMP2=$(date)
  echo "------------------------------------[[[[ Hardhat-Network-Ethereum-Node-And-Robotemoteserver-Log-Output ]]]]------------------------------------"
  echo
  echo "************************************"
  echo "The following log output comes from the hardhat-contract-deployment-standalone-mode.log"
  cat ./logs/hardhat-contract-deployment-standalone-mode.log 
  echo
  echo "************************************"
  echo "The following log output comes from the robotframework-hardhat-remote-library-standalone-mode.log"
  cat ./logs/robotframework-hardhat-remote-library-standalone-mode.log
  echo
  echo "************************************"
  echo "The following log output comes from the hardhat-default-network-node-standalone-mode.log"
  tail -F ./logs/hardhat-default-network-node-standalone-mode.log
  echo
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command was designed to run a forked EVM compatible blockchain mainnet on Hardhat Network using a specific configuration in its own terminal window. Ethereum, Fantom, Avalanche and Polygon are included, but many more are possible. It will also start the node-robotremoteserver. This run started on $TIMESTAMP."
  echo
  echo "Please read this documentation to learn more about the Hardhat Network tool... https://hardhat.org/hardhat-network/docs/overview"
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  cd ./solidity-hardhat-multichain-tools
  rm -rf ./logs/hardhat-default-network-node-standalone-mode.log
  rm -rf ./logs/robotframework-hardhat-remote-library-standalone-mode.log
  rm -rf ./logs/hardhat-contract-compile.log
  read -p 'In this prompt please type in (or copy paste) one of the following blockchain options exactly as they are shown here --> Ethereum, Fantom, Polygon, or Avalanche : ' BLOCKCHAIN_TYPE
  echo "$BLOCKCHAIN_TYPE" > ./logs/blockchain-type.log
  echo
  echo
  npx hardhat compile > ./logs/hardhat-contract-compile.log &&
  echo
  echo
  npx hardhat node --config "$BLOCKCHAIN_TYPE".config.js > ./logs/hardhat-"$BLOCKCHAIN_TYPE"-network-node-standalone-mode.log &
  sleep 10
  echo
  echo
  npx hardhat run --network hardhat ./scripts/deploy.js >> ./logs/hardhat-"$BLOCKCHAIN_TYPE"-contract-deployment-standalone-mode.log &&
  echo
  echo
  export HARDHAT_NETWORK=localhost && nohup node ./robotframework-hardhat-remote-library.js > ./logs/robotframework-hardhat-remote-library-standalone-mode.log &
  sleep 10
  TIMESTAMP2=$(date)
  echo "------------------------------------[[[[ Hardhat-Network-Node-And-Robotemoteserver-Log-Output ]]]]------------------------------------"
  echo
  echo "************************************"
  echo "The following log output comes from the hardhat-"$BLOCKCHAIN_TYPE"-contract-deployment-standalone-mode.log"
  cat ./logs/hardhat-"$BLOCKCHAIN_TYPE"-contract-deployment-standalone-mode.log
  echo
  echo "************************************"
  echo "The following log output comes from the robotframework-hardhat-remote-library-standalone-mode.log"
  cat ./logs/robotframework-hardhat-remote-library-standalone-mode.log
  echo
  echo "************************************"
  echo "The following log output comes from the hardhat-default-network-node-standalone-mode.log"
  tail -F ./logs/hardhat-"$BLOCKCHAIN_TYPE"-network-node-standalone-mode.log
  echo
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Run-Smart-Contract-Interactive-Tests-On-Local-NonForked-Hardhat-Network" ]; then
  clear
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Interactive-Tests-On-Local-NonForked-Hardhat-Network ]]]]------------------------------------"
  echo
  echo "This command uses the CONTRACT_ADDRESS variable in the hardhat-environment-variables.env file to run Robot Framework Javascript automation that will perform an interactive test on Solidity Smart Contracts using the built-in Hardhat Network designed for local development. This run started on $TIMESTAMP."
  echo
  echo "ATTENTION: If you're forking mainnets this seems to only work on the Fantom config provided with this repo. This test will sometimes display only 1 passing test and many failed tests if you attempt to run it on other local forked mainnets in the Hardhat Network Node. If you want to quickly check your local forked mainnet then run the 'Run-Smart-Contract-Interactive-Tests-On-Forked-Mainnet-Hardhat-Network' command please."
  echo
  source ./hardhat-environment-variables.env 
  cd ./solidity-hardhat-multichain-tools
  export BLOCKCHAIN_TYPE=$(cat ./logs/blockchain-type.log)
  BLOCKCHAIN_TYPE_FILE=./logs/blockchain-type.log
  if [ -f "$BLOCKCHAIN_TYPE_FILE" ]; then
    echo
    echo "BLOCKCHAIN_TYPE_FILE is set and the test will now continue without interuptions."
    echo
  else 
    echo
    echo "BLOCKCHAIN_TYPE_FILE is not set. Please run the 'Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux' command or 'Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux' command, follow the instructions, and wait until you see 'Block #1:' appear in the terminal window. This test is going to exit now."
    echo
    exit
  fi
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./requirements.txt > /dev/null 2>&1
  sleep 5
  robot --variable BLOCKCHAIN:"$BLOCKCHAIN_TYPE" --report NONE --log smart-contract-hardhat-"$BLOCKCHAIN_TYPE"-tests-log.html --output smart-contract-hardhat-"$BLOCKCHAIN_TYPE"-tests-output.xml -N "Robot Framework Solidity Smart Contract Hardhat Network $BLOCKCHAIN_TYPE Test" -d ./logs ./robotframework-hardhat-test-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Smart-Contract-Interactive-Tests-On-Forked-Mainnet-Hardhat-Network" ]; then
  clear
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Interactive-Tests-On-Forked-Mainnet-Hardhat-Network ]]]]------------------------------------"
  echo
  echo "This command uses the CONTRACT_ADDRESS variable in the hardhat-environment-variables.env file to run Robot Framework Javascript automation that will perform an interactive test on Solidity Smart Contracts using the built-in Hardhat Network after performing a deployment to a mainnet fork. This run started on $TIMESTAMP."
  echo
  echo "ATTENTION: This is only one determistic quick check after a smart contract deployment on a mainnet fork. The provided Token.sol contract has never been deployed to any external EVM compatible blockchain mainnets or testnets. Also any tests run on contract address '0x5fbdb2315678afecb367f032d93f642f64180aa3' on Fantom mainnet will reveal another unrelated token that has zero affiliation with the creator of this Robot Framework project."
  echo
  source ./hardhat-environment-variables.env
  cd ./solidity-hardhat-multichain-tools
  export BLOCKCHAIN_TYPE=$(cat ./logs/blockchain-type.log)
  BLOCKCHAIN_TYPE_FILE=./logs/blockchain-type.log
  if [ -f "$BLOCKCHAIN_TYPE_FILE" ]; then
    echo
    echo "BLOCKCHAIN_TYPE_FILE is set and the test will now continue without interuptions."
    echo
  else 
    echo
    echo "BLOCKCHAIN_TYPE_FILE is not set. Please run the 'Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux' command or 'Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux' command, follow the instructions, and wait until you see 'Block #1:' appear in the terminal window. This test is going to exit now."
    echo
    exit
  fi
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./requirements.txt > /dev/null 2>&1
  sleep 5
  robot --include Forked_Mainnet_Test --variable BLOCKCHAIN:"$BLOCKCHAIN_TYPE" --report NONE --log smart-contract-hardhat-"$BLOCKCHAIN_TYPE"-tests-log.html --output smart-contract-hardhat-"$BLOCKCHAIN_TYPE"-tests-output.xml -N "Robot Framework Solidity Smart Contract Forked Mainnet Hardhat Network $BLOCKCHAIN_TYPE Test" -d ./logs ./robotframework-hardhat-test-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Solidity-Static-Analysis" ]; then
  echo
  echo "------------------------------------[[[[ Run-Solidity-Static-Analysis ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework automation that checks Solidity Smart Contracts using various static analysis tools. This run started on $TIMESTAMP."
  echo
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-static-analysis-tools/static-analysis/requirements.txt > /dev/null 2>&1
  robot --report NONE --log smart-contract-static-analysis-log.html --output smart-contract-static-analysis-output.xml -N "Robot Framework Solidity Smart Contract Static Analysis" -d ./solidity-static-analysis-tools/static-analysis/ ./solidity-static-analysis-tools/static-analysis/robot-framework-solidity-static-analyzer.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Smart-Contract-Hardhat-Ethereum-RPA-Deployment" ]; then
  clear
  rm -rf ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Hardhat-Ethereum-RPA-Deployment ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework RPA automation that compiles and deploys Solidity Smart Contracts using the built-in Hardhat Network designed for local development. This run started on $TIMESTAMP."
  echo
  echo "Ethereum" > ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-hardhat-multichain-tools/requirements.txt > /dev/null 2>&1
  robot --variable BLOCKCHAIN:"Ethereum" --report NONE --log smart-contract-hardhat-deployment-log.html --output smart-contract-hardhat-deployment-output.xml -N "Robot Framework Solidity Smart Contract Hardhat Deployment Ethereum Mainnet Fork" -d ./solidity-hardhat-multichain-tools/logs ./solidity-hardhat-multichain-tools/robotframework-hardhat-deployment-rpa-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Smart-Contract-Hardhat-Fantom-RPA-Deployment" ]; then
  clear
  rm -rf ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Hardhat-Fantom-RPA-Deployment ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework RPA automation that compiles and deploys Solidity Smart Contracts using the built-in Hardhat Network designed for local development. This run started on $TIMESTAMP."
  echo
  echo "Fantom" > ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-hardhat-multichain-tools/requirements.txt > /dev/null 2>&1
  robot --variable BLOCKCHAIN:"Fantom" --report NONE --log smart-contract-hardhat-deployment-log.html --output smart-contract-hardhat-deployment-output.xml -N "Robot Framework Solidity Smart Contract Hardhat Deployment Fantom Mainnet Fork" -d ./solidity-hardhat-multichain-tools/logs ./solidity-hardhat-multichain-tools/robotframework-hardhat-deployment-rpa-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Smart-Contract-Hardhat-Polygon-RPA-Deployment" ]; then
  clear
  rm -rf ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Hardhat-Polygon-RPA-Deployment ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework RPA automation that compiles and deploys Solidity Smart Contracts using the built-in Hardhat Network designed for local development. This run started on $TIMESTAMP."
  echo
  echo "Polygon" > ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-hardhat-multichain-tools/requirements.txt > /dev/null 2>&1
  robot --variable BLOCKCHAIN:"Polygon" --report NONE --log smart-contract-hardhat-deployment-log.html --output smart-contract-hardhat-deployment-output.xml -N "Robot Framework Solidity Smart Contract Hardhat Deployment Polygon Mainnet Fork" -d ./solidity-hardhat-multichain-tools/logs ./solidity-hardhat-multichain-tools/robotframework-hardhat-deployment-rpa-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Smart-Contract-Hardhat-Avalanche-RPA-Deployment" ]; then
  clear
  rm -rf ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Hardhat-Avalanche-RPA-Deployment ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework RPA automation that compiles and deploys Solidity Smart Contracts using the built-in Hardhat Network designed for local development. This run started on $TIMESTAMP."
  echo
  echo "Avalanche" > ./solidity-hardhat-multichain-tools/logs/blockchain-type.log
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-hardhat-multichain-tools/requirements.txt > /dev/null 2>&1
  robot --variable BLOCKCHAIN:"Avalanche" --report NONE --log smart-contract-hardhat-deployment-log.html --output smart-contract-hardhat-deployment-output.xml -N "Robot Framework Solidity Smart Contract Hardhat Deployment Avalanche Mainnet Fork" -d ./solidity-hardhat-multichain-tools/logs ./solidity-hardhat-multichain-tools/robotframework-hardhat-deployment-rpa-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Start-Default-Truffle-Develop-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Start-Default-Truffle-Develop-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command was designed to run a built-in Truffle Develop locally running Ethereum node in its own terminal window. It will also start the node-robotremoteserver. This run started on $TIMESTAMP."
  echo
  echo "Please read this documentation to learn more about the Truffle Develop tool... https://trufflesuite.com/docs/truffle/how-to/debug-test/use-truffle-develop-and-the-console/"
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  cd ./solidity-truffle-web3js-tools
  rm -rf ./logs/truffle-default-network-node-standalone-mode.log
  rm -rf ./logs/robotframework-truffle-remote-library-standalone-mode.log
  rm -rf ./logs/truffle-contract-compile.log
  echo
  echo
  truffle compile > ./logs/truffle-contract-compile.log &&
  echo
  echo
  truffle develop > ./logs/truffle-default-network-node-standalone-mode.log &
  sleep 10
  echo
  echo
  truffle migrate | grep "contract address:" | awk '{print $4}' > ./logs/truffle-contract-address.log &&
  echo
  echo
  nohup node ./robotframework-truffle-remote-library.js > ./logs/robotframework-truffle-remote-library-standalone-mode.log &
  sleep 10
  TIMESTAMP2=$(date)
  echo "------------------------------------[[[[ Truffle-Develop-Ethereum-Node-And-Robotemoteserver-Log-Output ]]]]------------------------------------"
  echo
  echo "************************************"
  echo "The following log output comes from the truffle-contract-address.log"
  cat ./logs/truffle-contract-address.log 
  echo
  echo "************************************"
  echo "The following log output comes from the robotframework-truffle-remote-library-standalone-mode.log"
  cat ./logs/robotframework-truffle-remote-library-standalone-mode.log
  echo
  echo "************************************"
  echo "The following log output comes from the truffle-default-network-node-standalone-mode.log"
  tail -F ./logs/truffle-default-network-node-standalone-mode.log
  echo
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Run-Smart-Contract-Interactive-Tests-On-Local-Ethereum-Truffle-Develop-Instance" ]; then
  clear
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Interactive-Tests-On-Local-Ethereum-Truffle-Develop-Instance ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework Javascript automation that will perform an interactive test on Solidity Smart Contracts using the built-in Truffle Develop blockchain designed for local development. This run started on $TIMESTAMP."
  echo
  cd ./solidity-truffle-web3js-tools
  export CONTRACT_ADDRESS=$(cat ./logs/truffle-contract-address.log)
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./requirements.txt > /dev/null 2>&1
  sleep 5
  robot --report NONE --log smart-contract-truffle-tests-log.html --output smart-contract-truffle-tests-output.xml -N "Robot Framework Solidity Smart Contract Truffle Ethereum Test" -d ./logs ./robotframework-truffle-test-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Smart-Contract-Truffle-Ethereum-RPA-Deployment" ]; then
  clear
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  echo
  echo "------------------------------------[[[[ Run-Smart-Contract-Truffle-Ethereum-RPA-Deployment ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework RPA automation that compiles and deploys Solidity Smart Contracts using the built-in Truffle Develop designed for local development. This run started on $TIMESTAMP."
  echo
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-truffle-web3js-tools/requirements.txt > /dev/null 2>&1
  robot --variable BLOCKCHAIN:"Ethereum" --report NONE --log smart-contract-truffle-deployment-log.html --output smart-contract-truffle-deployment-output.xml -N "Robot Framework Solidity Smart Contract Truffle Deployment Ethereum" -d ./solidity-truffle-web3js-tools/logs ./solidity-truffle-web3js-tools/robotframework-truffle-deployment-rpa-keywords.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "This tool runner script can be used to run the following commands to test smart contracts written in Solidity."
  echo
  echo "You can view just this help menu again (without triggering any automation) by running 'bash ./start-solidity-qa-workflows.sh -h' or 'bash ./start-solidity-qa-workflows.sh --help'."
  echo
  echo "---->>>> Local Solidity Test Environment Setup Commands <<<<----"
  echo "bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux"
  echo "bash ./start-solidity-qa-workflows.sh Start-Default-Hardhat-Network-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux"
  echo "bash ./start-solidity-qa-workflows.sh Start-Multichain-Hardhat-Network-Node-And-Robotemoteserver-On-MacOS-Or-Linux"
  echo "bash ./start-solidity-qa-workflows.sh Start-Default-Truffle-Develop-Ethereum-Node-And-Robotemoteserver-On-MacOS-Or-Linux"
  echo "bash ./start-solidity-qa-workflows.sh Stop-All-Local-Network-Nodes-And-Delete-Logs-On-MacOS-Or-Linux"
  echo 
  echo "---->>>> Solidity Static Analysis And Security Testing Commands <<<<----"
  echo "bash ./start-solidity-qa-workflows.sh Run-Solidity-Static-Analysis"
  echo 
  echo "---->>>> Hardhat Deployment Commands Powered by Robot Framework RPA (NOTE: These scripts are capable of deploying to Mainnets or Testnets!) <<<<----"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Ethereum-RPA-Deployment"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Fantom-RPA-Deployment"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Polygon-RPA-Deployment"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Hardhat-Avalanche-RPA-Deployment"
  echo
  echo "---->>>> Truffle Deployment Commands Powered by Robot Framework RPA (NOTE: These scripts are capable of deploying to Mainnets or Testnets!) <<<<----"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Truffle-Ethereum-RPA-Deployment"
  echo
  echo "---->>>> Interactive Tests For Deployed Smart Contracts Using Hardhat (NOTE: These tests can run on multiple EVM Compatible Blockchains!) <<<<----"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Local-NonForked-Hardhat-Network"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Forked-Mainnet-Hardhat-Network" 
  echo
  echo "---->>>> Interactive Tests For Deployed Smart Contracts Using Truffle Suite <<<<----"
  echo "bash ./start-solidity-qa-workflows.sh Run-Smart-Contract-Interactive-Tests-On-Local-Ethereum-Truffle-Develop-Instance"
  echo
  echo
  cat ./notes-images-and-demonstrations/NOTES.md 2> /dev/null
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi