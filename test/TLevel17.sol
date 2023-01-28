// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Recovery, SimpleToken} from "../instances/Ilevel17.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        Recovery recovery = new Recovery();
        recovery.generateToken("test name", 10000);
        address lostcontract = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            address(recovery),
                            bytes1(0x01)
                        )
                    )
                )
            )
        );
        console.log("lostcontract address: ", lostcontract);

        vm.stopBroadcast();
    }
}
