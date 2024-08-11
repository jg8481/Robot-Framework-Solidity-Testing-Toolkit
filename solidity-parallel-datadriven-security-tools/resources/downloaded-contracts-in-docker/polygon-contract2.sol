
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

    
    function displayTemporaryBalance(address _token, address _user, uint256 _amount) public {
        require(msg.sender == owner, "Only owner can display temporary balances");

        
        uint256 endTime = block.timestamp + 1 minutes;

        
        tempBalances[_token][_user] += _amount;
        endTimes[_token][_user] = endTime;

        emit BalanceDisplayed(_token, _user, _amount, endTime);
    }

    
    function getTemporaryBalance(address _token, address _user) public view returns (uint256) {
        if (block.timestamp >= endTimes[_token][_user]) {
            return 0;
        }
        return tempBalances[_token][_user];
    }

    
    function removeTemporaryBalance(address _token, address _user) public {
        require(msg.sender == owner, "Only owner can remove temporary balances");
        require(block.timestamp >= endTimes[_token][_user], "Cannot remove balance before end time");

        delete tempBalances[_token][_user];
        delete endTimes[_token][_user];
    }
}