#! /bin/bash

set -uo pipefail

clear
TIMESTAMP=$(date)

if [ "$1" == "Clean-Up-Old-Test-Runs" ]; then
  echo
  echo "------------------------------------[[[[ Clean-Up-Old-Test-Runs ]]]]------------------------------------"
  echo
  echo "This command will clean up old unit and acceptance test runs. This run started on $TIMESTAMP."
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  rm -rf ./utest/unit-test-resources/*unit-test-log
  rm -rf ./atest/acceptance-test-resources/*acceptance-test-log
  ls -la ./utest/unit-test-resources
  ls -la ./atest/acceptance-test-resources
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Run-Acceptance-Tests" ]; then
  echo
  echo "------------------------------------[[[[ Run-Acceptance-Tests ]]]]------------------------------------"
  echo
  echo "This command will run acceptance tests. This run started on $TIMESTAMP."
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  rm -rf ./atest/acceptance-test-resources/*acceptance-test-log
  export CURRENT_PATH=$(pwd)
  cd ./solidity-hardhat-multichain-tools
  source ./hardhat-environment-variables.env 
  cd "$CURRENT_PATH"
  cd ./atest
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash &&
  # export NVM_DIR="$HOME/.nvm"
  # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # nvm install 18
  # nvm use 18
  # nvm alias default 18
  npm install -g bats
  # npm install robotremote
  # npm update
  # npm audit fix --force
  echo
  echo
  clear
  bats -h > /dev/null && 
  if [ $? -eq 0 ]; then
    echo
    echo "BATS installation has completed without issues. This test will continue as planned."
    echo
  else 
    echo
    echo "WARNING! BATS did not install properly. Please check the 'npm install -g bats' installation command and the 'start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux' script."
    echo
    exit 1
  fi
  echo
  echo
  ls -la
  TIMESTAMP2=$(date)
  echo "This run ended at around $TIMESTAMP2."
  bats ./acceptance-tests.bats --timing
  BATS_EXIT_STATUS=$?
  echo "BATS test framework exit status: $BATS_EXIT_STATUS"
  exit $BATS_EXIT_STATUS
fi

if [ "$1" == "Run-Unit-Tests" ]; then
  echo
  echo "------------------------------------[[[[ Run-Unit-Tests ]]]]------------------------------------"
  echo
  echo "This command will run unit tests. This run started on $TIMESTAMP."
  echo
  killall node > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall robot > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill robot > /dev/null 2>&1
  rm -rf ./utest/unit-test-resources/*unit-test-log
  rm -rf ./utest/unit-test-resources/robotframework-hardhat-test-keywords.robot
  export CURRENT_PATH=$(pwd)
  cd ./solidity-hardhat-multichain-tools
  source ./hardhat-environment-variables.env 
  nohup node ./robotframework-hardhat-remote-library.js > "$CURRENT_PATH"/utest/unit-test-resources/robotframework-hardhat-remote-library-standalone-mode.unit-test-log  &
  sleep 5
  cd "$CURRENT_PATH"
  cd ./utest
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash &&
  # export NVM_DIR="$HOME/.nvm"
  # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # nvm install 18
  # nvm use 18
  # nvm alias default 18
  npm install -g bats
  # npm install robotremote
  # npm update
  # npm audit fix --force
  echo
  echo
  clear
  bats -h > /dev/null && 
  if [ $? -eq 0 ]; then
    echo
    echo "BATS installation has completed without issues. This test will continue as planned."
    echo
  else 
    echo
    echo "WARNING! BATS did not install properly. Please check the 'npm install -g bats' installation command and the 'start-solidity-qa-workflows.sh Install-Tools-On-MacOS-Or-Linux' script."
    echo
    exit 1
  fi
  echo
  echo
  ls -la
  TIMESTAMP2=$(date)
  echo "This run ended at around $TIMESTAMP2."
  bats ./unit-tests.bats --timing
  BATS_EXIT_STATUS=$?
  echo "BATS test framework exit status: $BATS_EXIT_STATUS"
  exit $BATS_EXIT_STATUS
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "This tool runner script can be used to run the following unit tests and acceptance tests for this toolkit."
  echo
  echo "You can view just this help menu again (without triggering any automation) by running 'bash ./toolkit-maintenance-workflows.sh -h' or 'bash ./toolkit-maintenance-workflows.sh --help'."
  echo
  echo "bash ./start-maintenance-workflows.sh Clean-Up-Old-Test-Runs"
  echo "bash ./start-maintenance-workflows.sh Run-Unit-Tests"
  echo "bash ./start-maintenance-workflows.sh Run-Acceptance-Tests"
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