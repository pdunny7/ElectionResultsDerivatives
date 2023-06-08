ElectionOracle.sol

pragma solidity ^0.6.7;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract ElectionOracle is ChainlinkClient {
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    string public electionData;

    constructor(address _oracle, string memory _jobId, uint256 _fee) public {
        setPublicChainlinkToken();
        oracle = _oracle;
        jobId = stringToBytes32(_jobId);
        fee = _fee;
    }

    function requestElectionData(string memory _electionId) public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        request.add("get", string(abi.encodePacked("https://api.ap.org/v2/elections/", _electionId)));
        request.add("path", "results");
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    function fulfill(bytes32 _requestId, bytes32 _electionData) public recordChainlinkFulfillment(_requestId) {
        electionData = bytes32ToString(_electionData);
    }

    function bytes32ToString(bytes32 _bytes32) internal pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for(i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

    function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly { // solhint-disable-line no-inline-assembly
            result := mload(add(source, 32))
        }
    }
}
