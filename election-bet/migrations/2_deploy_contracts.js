const ElectionBetMarket = artifacts.require('ElectionBetMarket');

module.exports = function(deployer) {
  const oracleAddress = '0xE176672151FFF04d7556752a6660822D3684BEAa'; // Enclose the address in quotes
  const jobId = web3.utils.utf8ToHex('210b1434c0564d6fbafbbd1c4bb24c6e'); // Convert the hex string using utf8ToHex
  const feeAmount = web3.utils.toBN('1000000000000000000'); // Replace with the actual fee amount in LINK tokens
  const tokenAddress = '0x326C977E6efc84E512bB9C30f76E30c160eD06FB'; // Enclose the address in quotes

  deployer.deploy(ElectionBetMarket, oracleAddress, jobId, feeAmount, tokenAddress);
};
