#!/bin/bash

cd /tasks
ls -la
echo
echo "Installing all of the NodeJS packages inside the Docker Container."
echo
npm update > /dev/null 2>&1
npm install robotremote > /dev/null 2>&1
npm install -g wscat > /dev/null 2>&1
echo
echo "NodeJS packages are installed. Now the EthersJS Bot will run."
echo
robot --report NONE --log infura-websocket-task-bot-log.html --output infura-websocket-task-bot-output.xml -N "Robot Framework Infura Websocket Bot Task" -d ./logs ./robotframework-infura-websocket-bot-rpa-keywords.robot
