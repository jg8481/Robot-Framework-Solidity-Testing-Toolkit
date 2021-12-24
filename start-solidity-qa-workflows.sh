#! /bin/bash

clear
TIMESTAMP=$(date)


if [ "$1" == "Install-Tools-On-MacOS" ]; then
  echo
  echo "------------------------------------[[[[ Install-Tools-On-MacOS ]]]]------------------------------------"
  echo
  echo "This command will install all of the required NodeJS packages. This run started on $TIMESTAMP."
  echo
  npm install -g npm-check-updates
  ncu -u
  npm update
  npm install -g solhint
  npm install -g solgraph
  npm install -g surya
  npm install -g truffle
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Run-Solidity-QA-Checks" ]; then
  echo
  echo "------------------------------------[[[[ Run-Solidity-QA-Checks ]]]]------------------------------------"
  echo
  echo "This command will run Robot Framework automation that checks BEP-20 or ERC-20 Solidity Smart Contracts. This run started on $TIMESTAMP."
  echo
  pip3 install virtualenv --user > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./solidity-smart-contract-test-tools/test/requirements.txt > /dev/null 2>&1
  robot --report NONE --log smart-contract-testing-log.html --output smart-contract-testing-output.xml -N "Robot Framework Solidity Smart Contract Test" -d ./solidity-smart-contract-test-tools/test/ ./solidity-smart-contract-test-tools/test/robot-framework-solidity-tester.robot
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  rm -rf ./solidity-smart-contract-test-tools/build > /dev/null 2>&1
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
  echo "bash ./start-solidity-qa-workflows.sh Install-Tools-On-MacOS"
  echo "bash ./start-solidity-qa-workflows.sh Run-Solidity-QA-Checks"
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