// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import { CredentialsVerifier } from 'src/CredentialsVerifier.sol';

contract CredentialsVerifierScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new CredentialsVerifier();
    }
}