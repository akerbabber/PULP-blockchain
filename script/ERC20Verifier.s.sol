// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import { ERC20Verifier } from 'src/ERC20Verifier.sol';

contract ERC20VerifierScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new ERC20Verifier("PULP", "PULP");
    }
}