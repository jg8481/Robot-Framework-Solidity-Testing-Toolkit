# General notes, observations, and advice from Josh (this toolkit's creator)

## [1] Some advice for Windows Users

I recommend installing all of this into a VMWare VM or VirtualBox VM that is running a Linux distribution of your choice. Either of those should work out for you just fine. I prefer whatever Linux distro `hardhat` recommends in their documentation, which could change at any time.  I personally use VMware products with an Ubuntu LTS, and it works nicely for my work. If you're a VirtualBox user this approach could work really well with Hashicorp's Vagrant.

If neither of those VM options seem useful to you, there are Windows blockchain technologists out there who are using the WSL2 (Windows Subsystem for Linux) for working with the various blockchain tech stacks (source: https://michaeljohnpena.com/blog/blockchain-wsl2/).

## [2] The ethereum-waffle and hardhat-chai-matchers announcements from the `hardhat` community

If you see the following message every time you run (or Robot Framework runs) this type of command `npx hardhat <task-name-goes-here>`...

```
"You have both ethereum-waffle and @nomicfoundation/hardhat-chai-matchers installed. They don't work correctly together, so please make sure you only use one."

"We recommend you migrate to @nomicfoundation/hardhat-chai-matchers. Learn how to do it here: https://hardhat.org/migrate-from-waffle"
```

Go to the link they suggest and read the details of their announcement, or just run `npm uninstall @nomiclabs/hardhat-waffle ethereum-waffle`. This uninstall command will make the that annoying error message from the `hardhat` community go away.

## [3] Try to learn how the Robot Framework tools are interacting with the Ethereum tools

I created the `start-solidity-qa-workflows.sh` Bash script to help automate standalone workflows ([in case anyone wants to use this with cron schedulers, CI, etc.](https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/actions)) and guide users of this toolkit through helpful prompts and messages in the terminal output. It's a good idea to learn the terminal commands in this toolkit and run them one at a time to see what they do. Here is an outline of how these tools can be orchestrated manually.

Steps to manually run and learn the flow of the Hardhat tools, and the Robot Framework Hardhat library that I built on top of `node-robotremoteserver` (source: https://github.com/comick/node-robotremoteserver).
- From the `solidity-hardhat-multichain-tools` root directory, open a terminal and run the following...
  - npx hardhat compile
  - npx hardhat node

- Open a second terminal in the `solidity-hardhat-multichain-tools` root directory again, and run the following...
  - npx hardhat run --network localhost ./scripts/deploy.js
  - cd ./robotremoteserver && export HARDHAT_NETWORK=localhost && node ./robotframework-hardhat-remote-libraryjs

- Open a third terminal in the `solidity-hardhat-multichain-tools` root directory again, and run the following...
  - cd ./test && robot ./robotframework-hardhat-keywords-test.robot
  
- At this point, the tests should be running and you should see logs flowing from `hardhat` and the `robotframework-hardhat-remote-libraryjs`.

