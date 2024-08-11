#!/bin/bash

if [ "$1" == "Stop-Docker-Containers-Setup-Napalm-And-Mythril" ]; then
  # source ./.env
  echo
  echo "------------------------------------[[[[ Stop-Docker-Containers-Setup-Napalm-And-Mythril ]]]]------------------------------------"
  echo
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  docker compose -f docker-compose.yml down
  docker compose -f docker-compose.yml rm -f
  docker compose -f docker-compose.yml build
  docker pull mythril/myth
  TIMESTAMP2=$(date)
  echo "This build ended on $TIMESTAMP2."
fi

if [ "$1" == "Run-Consensys-Mythril-In-Docker-Using-Robot-Framework" ]; then
  clear
  echo
  echo "------------------------------------[[[[ Run-Consensys-Mythril-In-Docker-Using-Robot-Framework ]]]]------------------------------------"
  echo
  cd ./resources
  pwd
  ls -la
  echo
  echo "Now running...'mythril/myth analyze "$3" -o markdown'" >> ./mythril/"$4"-"$5"-mythril-output.log
  docker run -v "$2":/tmp mythril/myth analyze "$3" -o markdown >> ./mythril/"$4"-"$5"-mythril-output.log
  #Mythril Docker Container Check#---> docker run -v "$2":/tmp mythril/myth ls -la "/tmp/downloaded-contracts-in-docker"
  TIMESTAMP2=$(date)
  exit
fi

if [ "$1" == "Start-Consensys-Napalm-In-Docker-Container" ]; then
  clear
  echo
  echo "------------------------------------[[[[ Start-Consensys-Napalm-In-Docker-Container ]]]]------------------------------------"
  echo
  ls -la /tmp/napalm/
  yes | napalm run --help
  echo "====================================" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  echo "Now running...'napalm run detect'" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  napalm run detect "$2"  >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  echo "====================================" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  echo "Now running...'napalm run direct'" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  napalm run direct "$2" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  echo "====================================" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  echo "Now running...'napalm run inform'" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  napalm run inform "$2" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  echo "====================================" >> /tmp/napalm/"$3"-"$4"-napalm-output.log
  cat /tmp/napalm/"$3"-"$4"-napalm-output.log | grep -v slither | grep -v locally > /tmp/napalm/"$3"-"$4"-napalm-filtered-output.log
  mv /tmp/napalm/"$3"-"$4"-napalm-filtered-output.log /tmp/napalm/"$3"-"$4"-napalm-output.log
  cat /tmp/napalm/"$3"-"$4"-napalm-output.log
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
  exit
fi

if [ "$1" == "Run-Consensys-Napalm-In-Docker-Using-Robot-Framework" ]; then
  echo
  echo "------------------------------------[[[[ Run-Consensys-Napalm-In-Docker-Using-Robot-Framework ]]]]------------------------------------"
  echo
  cd ./resources
  pwd
  ls -la
  docker compose -f docker-compose.yml down
  docker compose -f docker-compose.yml rm -f
  docker compose -f docker-compose.yml build
  docker compose run docker-solidity-security-test-runner run-solidity-security-tests.sh Start-Consensys-Napalm-In-Docker-Container "$2" "$3" "$4"
  docker compose -f docker-compose.yml down
  docker compose -f docker-compose.yml rm -f
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
  exit
fi
