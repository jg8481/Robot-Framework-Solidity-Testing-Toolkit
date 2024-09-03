#!/bin/bash

cd /tasks
ls -la
echo
echo "Installing all of the NodeJS packages inside the Docker Container."
echo
npm update > /dev/null 2>&1
npm install robotremote > /dev/null 2>&1
npm install alchemy-sdk > /dev/null 2>&1
echo
echo "NodeJS packages are installed. Now the Alchemy SDK Bot will run."
echo
sleep 2s
nohup node ./robotframework-alchemy-sdk-bot-remote-library.js > ./logs/robotframework-alchemy-sdk-bot-remote-library.log &
sleep 2s
robot --report NONE --log alchemy-sdk-task-bot-log.html --output alchemy-sdk-task-bot-output.xml -N "Robot Framework Alchemy SDK Bot Task" -d ./logs ./robotframework-alchemy-sdk-bot-rpa-keywords.robot
