// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {GatekeeperTwo} from "../instances/Ilevel14.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        LetMeThrough lmt = new LetMeThrough();
        lmt.exploit();
        vm.stopBroadcast();
    }
}

contract LetMeThrough {
    GatekeeperTwo gate = new GatekeeperTwo();

    function exploit() external {
        // bytes8 myKey = bytes8(
        //     uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
        //         (uint64(0) - 1)
        // );
        // gate.enter(myKey);
    }
}
