// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Fallback} from "../instances/Ilevel01.sol";

contract Attacker is Test {
    Fallback fb = new Fallback();

    function test() external {}
}
