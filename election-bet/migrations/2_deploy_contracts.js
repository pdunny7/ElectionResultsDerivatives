const ElectionBetMarket = artifacts.require('ElectionBetMarket');

module.exports = function(deployer) {
  const oracleAddress = 0xE176672151FFF04d7556752a6660822D3684BEAa; // Replace with the actual oracle address
  const jobId = web3.utils.utf8ToHex(0x3231306231343334633035363464366662616662626431633462623234633665); // Replace with the actual job ID
  const feeAmount = 100000000000000000; // Replace with the actual fee amount in LINK tokens
  const tokenAddress = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB; // Replace with the actual token address

  deployer.deploy(ElectionBetMarket, oracleAddress, jobId, feeAmount, tokenAddress);
};