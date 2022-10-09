// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {CredentialsVerifier} from "src/CredentialsVerifier.sol";
import "../src/interfaces/ICircuitValidator.sol";

contract zkRequestScript is Script {
    string public constant circuitId = "credentialAtomicQuerySig";
    address public constant validatorAddress =
        0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
    address public constant verifierAddress =
        0x5FbDB2315678afecb367f032d93F642f64180aa3;
    struct CircuitQuery {
        uint256 schema;
        uint256 slotIndex;
        uint256 operator;
        uint256[] value;
        string circuitId;
    }

    uint256 public constant ageSchema = 302764035255313010381745356924282665239;
    uint256 public constant creditScoreSchema = 11159900042574581856801525453324566470;
    uint256 public constant GPASchema = 283499881902454673272685922038101407466;
    uint256 public constant SheFiSchema = 108777859205721303425804591379005715984;
    uint256 public constant BanklessDAOSchema = 78835905640567421504376891938783661998;
    uint256 public constant incomeSchema = 320637089358724701904569884896386819229;

    uint64 public requestId;
    CredentialsVerifier verifier;

    function setUp() public {
        verifier = new CredentialsVerifier();
    }

    function test1() public {
        ICircuitValidator.CircuitQuery memory ageQuery;

        ageQuery.schema = ageSchema;
        ageQuery.slotIndex = 2;
        ageQuery.operator = 2;
        ageQuery.value = new uint256[](1);
        ageQuery.value[0] = 18;
        ageQuery.circuitId = circuitId;
        console.logAddress(address(verifier));

        requestId = verifier.AGE_CHECK_ID();

        verifier.setZKPRequest(
            requestId,
            ICircuitValidator(validatorAddress),
            ageQuery
        );
    }


    //  function setUp() public {}
    //
    //  function run() public {
    //      vm.broadcast();
    //      new ERC20Verifier("PULP", "PULP");
    //  }
}
