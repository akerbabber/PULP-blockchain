// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {ERC20Verifier} from "src/ERC20Verifier.sol";
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
    uint64 public requestId;

    function run() public {
        ERC20Verifier verifier = ERC20Verifier(verifierAddress);

        ICircuitValidator.CircuitQuery memory ageQuery;

        ageQuery.schema = 302764035255313010381745356924282665239;
        ageQuery.slotIndex = 2;
        ageQuery.operator = 2;
        ageQuery.value =  new uint[](1);
        ageQuery.value[0] = 20020101;
        ageQuery.circuitId = circuitId;

        requestId = verifier.TRANSFER_REQUEST_ID();

        verifier.setZKPRequest(requestId, ICircuitValidator(validatorAddress), ageQuery);
    }
    //  function setUp() public {}
    //
    //  function run() public {
    //      vm.broadcast();
    //      new ERC20Verifier("PULP", "PULP");
    //  }
}
