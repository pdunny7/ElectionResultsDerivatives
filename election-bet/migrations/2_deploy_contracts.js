const ElectionBetMarket = artifacts.require('ElectionBetMarket');

module.exports = function(deployer) {
  const oracleAddress = 0xE176672151FFF04d7556752a6660822D3684BEAa; // Replace with the actual oracle address
  const jobId = web3.utils.utf8ToHex(0x3231306231343334633035363464366662616662626431633462623234633665); // Replace with the actual job ID
  const feeAmount = 0.1; // Replace with the actual fee amount in LINK tokens
  const tokenAddress = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB; // Replace with the actual token address

  // Convert the fee amount to wei (smallest unit of LINK token)
  const fee = web3.utils.toBN(feeAmount).mul(web3.utils.toBN(10).pow(web3.utils.toBN(18))); // Assuming LINK has 18 decimals

  deployer.deploy(ElectionBetMarket, oracleAddress, jobId, fee, tokenAddress);
};