pragma solidity ^0.6.7;

contract ElectionBet {
    enum ElectionResult { Undecided, Candidate1, Candidate2 }

    ElectionResult public result = ElectionResult.Undecided;
    mapping(address => ElectionResult) public bets;

    ElectionOracle oracle;

    constructor(ElectionOracle _oracle) public {
        oracle = _oracle;
    }

    function placeBet(ElectionResult _bet) public {
        require(result == ElectionResult.Undecided, "Betting is closed");
        bets[msg.sender] = _bet;
    }

    function resolve(ElectionResult _result) public {
        result = _result;
    }

    function updateResult(uint256 _result) public {
        require(msg.sender == address(oracle), "Only the oracle can update the result");
        if(_result == 0) {
            resolve(ElectionResult.Candidate1);
        } else if(_result == 1) {
            resolve(ElectionResult.Candidate2);
        }
    }

    function claim() public {
        require(result != ElectionResult.Undecided, "Election is not yet decided");
        require(bets[msg.sender] == result, "Your bet did not win");
        msg.sender.transfer(address(this).balance);
    }
}
