// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {MagicNum} from "../instances/Ilevel18.sol";

contract Attacker is Test {
    function test() external {
        vm.startBroadcast();
        MagicNum mn = new MagicNum();

        // Initialization Opcode: 600a600c600039600a6000f3
        // 60 PUSH
        // 0a
        // 60 PUSH
        // 0c
        // 60 PUSH
        // 00
        // 39 (CODECOPY)
        // 60 PUSH
        // 0a (Size of opcode is 10 bytes)
        // 60 PUSH
        // 00 (Value was stored in slot 0x00)
        // f3 (RETURN: Return value at p=0x00 slot and of size s=0x0a)

        // Runtime Opcodes: 602a608052
        // 60 PUSH
        // 2a (Value: 42)
        // 60 PUSH
        // 80 (Offset: slot 80)
        // 52 (MSTORE: Store value p=0x2a at position v=0x80 in memory)
        // 60 PUSH
        // 20 (Size: 32)
        // 60 PUSH
        // 80 (Offset: slot 80)
        // f3 (RETURN: Return value at p=0x80 slot and of size s=0x20)
        bytes
            memory code = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solver;

        assembly {
            solver := create(0, add(code, 0x20), mload(code))
        }

        console.log("solver address: ", solver);
        mn.setSolver(solver);
        vm.stopBroadcast();
    }
}
