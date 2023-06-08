pragma solidity ^0.6.7;

contract ElectionBet {
    enum ElectionResult { Undecided, Candidate1, Candidate2 }

    ElectionResult public result = ElectionResult.Undecided;
    mapping(address => ElectionResult) public bets;

    function placeBet(ElectionResult _bet) public {
        require(result == ElectionResult.Undecided, "Betting is closed");
        bets[msg.sender] = _bet;
    }

    function resolve(ElectionResult _result) public {
        result = _result;
    }

    function claim() public {
        require(result != ElectionResult.Undecided, "Election is not yet decided");
        require(bets[msg.sender] == result, "Your bet did not win");
        msg.sender.transfer(address(this).balance);
    }
}