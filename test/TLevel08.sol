// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        vm.stopBroadcast();
    }
}
