// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
    * Contract which implements a simple guessing game
*/
contract GuessNumber {

    mapping(address=>bool) winners;

    // Check if a player was able to guess the number
    function guess(uint256 number, address player) public {
        require(random() == number, "Try Again");
        winners[player] = true;
    }

    // Check if a player has beaten the contract
    function isWinner(address player) public view returns (bool) {
        return winners[player];
    }

    // Generate a pseudo random number
    function random() internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            blockhash(block.difficulty),
            blockhash(block.number - 1),
            block.timestamp
        )));
    }
}