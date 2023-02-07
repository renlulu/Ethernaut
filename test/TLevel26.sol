// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {DoubleEntryPoint, Forta, LegacyToken, CryptoVault} from "../instances/Ilevel26.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        LegacyToken legacyToken = new LegacyToken();
        Forta forta = new Forta();
        CryptoVault vault = new CryptoVault(msg.sender);
        DoubleEntryPoint dep = new DoubleEntryPoint(
            address(legacyToken),
            address(vault),
            address(forta),
            msg.sender
        );
        vm.stopBroadcast();
    }
}

contract Destructive {
    function killed() external {
        selfdestruct(payable(address(0)));
    }
}
