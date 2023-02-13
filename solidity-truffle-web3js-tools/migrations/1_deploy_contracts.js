const testToken = artifacts.require("Token");

module.exports = function(deployer) {
  deployer.deploy(testToken);
};
