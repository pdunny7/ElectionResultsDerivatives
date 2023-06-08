var ElectionOracle = artifacts.require("ElectionOracle");
var ElectionBet = artifacts.require("ElectionBet");

module.exports = function(deployer) {
  deployer.deploy(ElectionOracle).then(function() {
    return deployer.deploy(ElectionBet, ElectionOracle.address);
  });
};