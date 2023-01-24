// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../instances/Ilevel00.sol";

contract Attacker is Test {
    Instance level0 = new Instance("pwd");

    function test() external {
        vm.startBroadcast();
        string memory info = level0.info();
        console.log("info: %s", info);
        string memory info1 = level0.info1();
        console.log("info1: %s", info1);
        string memory info2 = level0.info2("hello");
        console.log("info2: %s", info2);
        uint8 infoNum = level0.infoNum();
        console.log("infoNum: %d", infoNum);
        string memory info42 = level0.info42();
        console.log("info42: %s", info42);
        string memory theMethodName = level0.theMethodName();
        console.log("theMethodName: %s", theMethodName);
        string memory method7123949 = level0.method7123949();
        console.log("method7123949: %s", method7123949);
        level0.authenticate(level0.password());
        vm.stopBroadcast();
    }
}
