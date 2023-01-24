// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

contract Telephone is Test {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        console.log("tx.origin: %s, msg.sender: %s", tx.origin, msg.sender);
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}
