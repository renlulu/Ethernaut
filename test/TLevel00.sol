// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../instances/Ilevel00.sol";

contract Attacker is Test {
    Instance level0 = new Instance("pwd");

    function test() external {
        vm.startBroadcast();
        string memory info = level0.info();
        console.log("info: %s", info);
        string memory info1 = level0.info1();
        console.log("info1: %s", info1);
        level0.password();
        level0.authenticate(level0.password());
        vm.stopBroadcast();
    }
}
