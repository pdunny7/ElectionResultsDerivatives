pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ElectionBetMarket is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    IERC20 public token;

    struct Bet {
        uint256 electionId;
        bool isOpen;
        mapping(address => uint256) outcomes;
        mapping(address => uint256) bets;
    }

    mapping(uint256 => Bet) private bets;

    constructor(address _oracle, bytes32 _jobId, uint256 _fee, address _token) public {
        setPublicChainlinkToken();
        oracle = _oracle;
        jobId = _jobId;
        fee = _fee;
        token = IERC20(_token);
    }

    function createBet(uint256 electionId) public {
        Bet storage bet = bets[electionId];
        bet.electionId = electionId;
        bet.isOpen = true;
    }

    function placeBet(uint256 electionId, uint256 outcome, uint256 amount) public {
        Bet storage bet = bets[electionId];
        require(bet.isOpen, "Bet is not open.");

        token.transferFrom(msg.sender, address(this), amount);

        bet.outcomes[msg.sender] = outcome;
        bet.bets[msg.sender] = amount;
    }

    function closeBet(uint256 electionId) public {
        Bet storage bet = bets[electionId];
        require(bet.isOpen, "Bet is not open.");

        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        req.addUint("electionId", electionId);
        sendChainlinkRequestTo(oracle, req, fee);

        bet.isOpen = false;
    }

    function fulfill(bytes32 _requestId, bytes32 _firstName, bytes32 _lastName, uint256 _voteCount, bytes32 _candidateId, bytes32 _party, bytes[] memory _candidates) public recordChainlinkFulfillment(_requestId) {
        // Fulfill Chainlink data here, calculate winners and their winnings
        // Store the results for each bet for withdrawal in a separate mapping or struct

        emit WinnerFound(_firstName, _lastName, _voteCount, _candidateId, _party);
    }

    function withdrawWinnings(uint256 electionId) public {
        // Withdraw winnings here
        // Check if the sender has any winnings, send them and update their balance to 0
    }

    event WinnerFound(bytes32 firstName, bytes32 lastName, uint256 voteCount, bytes32 candidateId, bytes32 party);

    function getCandidate(uint256 _idx) external view returns (uint32, string memory, string memory, string memory, uint32, bool) {
         (uint32 decodedId, string memory decodedParty, string memory decodedFirstName, string memory decodedLastName, uint32 decodedVoteCount, bool decodedIsWinner) = 
            abi.decode(candidates[_idx], (uint32, string, string, string, uint32, bool));
        return (decodedId, decodedParty, decodedFirstName, decodedLastName, decodedVoteCount, decodedIsWinner);
    }
}
