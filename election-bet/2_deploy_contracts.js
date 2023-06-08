const MyContract = artifacts.require('ElectionBetMarket');

module.exports = function(deployer) {
  deployer.deploy(MyContract);
};