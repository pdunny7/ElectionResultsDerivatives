const ElectionBetMarket = artifacts.require("ElectionBetMarket");

module.exports = function (deployer) {
  const oracleAddress = "0xE176672151FFF04d7556752a6660822D3684BEAa"; // Replace with the actual oracle address
  const jobId = "0x6266303765656464616237373430363439616339613234303934346236316630"; // Replace with the actual job ID
  const fee = 1 LINK; // Replace with the actual fee amount in ether
  const tokenAddress = "0x514910771af9ca656af840dff83e8264ecf986ca"; // Replace with the actual token address

  deployer.deploy(ElectionBetMarket, oracleAddress, jobId, fee, tokenAddress);
};