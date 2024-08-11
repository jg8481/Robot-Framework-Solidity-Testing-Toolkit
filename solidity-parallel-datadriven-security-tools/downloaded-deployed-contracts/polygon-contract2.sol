// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract TemporaryBalance {
    address public owner;
    mapping(address => mapping(address => uint256)) public tempBalances;
    mapping(address => mapping(address => uint256)) public endTimes;

    event BalanceDisplayed(address indexed token, address indexed user, uint256 amount, uint256 endTime);

    constructor() {
        owner = msg.sender;
    }

    // Функция для отображения баланса токенов на временном адресе
    function displayTemporaryBalance(address _token, address _user, uint256 _amount) public {
        require(msg.sender == owner, "Only owner can display temporary balances");

        // Устанавливаем время окончания через 1 минуту
        uint256 endTime = block.timestamp + 1 minutes;

        // Добавляем временный баланс и время окончания
        tempBalances[_token][_user] += _amount;
        endTimes[_token][_user] = endTime;

        emit BalanceDisplayed(_token, _user, _amount, endTime);
    }

    // Функция для получения текущего временного баланса пользователя
    function getTemporaryBalance(address _token, address _user) public view returns (uint256) {
        if (block.timestamp >= endTimes[_token][_user]) {
            return 0;
        }
        return tempBalances[_token][_user];
    }

    // Функция для удаления временного баланса (по истечении времени)
    function removeTemporaryBalance(address _token, address _user) public {
        require(msg.sender == owner, "Only owner can remove temporary balances");
        require(block.timestamp >= endTimes[_token][_user], "Cannot remove balance before end time");

        delete tempBalances[_token][_user];
        delete endTimes[_token][_user];
    }
}