// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./lib/GenesisUtils.sol";
import "./interfaces/ICircuitValidator.sol";
import "./verifiers/ZKPVerifier.sol";

contract CredentialsVerifier is  ZKPVerifier {

    uint64 public constant AGE_CHECK_ID = 1;
    uint64 public constant CREDIT_SCORE_CHECK_ID = 2;
    uint64 public constant GPA_CHECK_ID = 3;
    uint64 public constant SHEFI_PARTICIPANT_CHECK_ID = 4;
    uint64 public constant BANKLESSDAO_PARTICIPANT_CHECK_ID = 5;
    uint64 public constant INCOME_CHECK_ID = 6;

    mapping(uint256 => address) public idToAddress;
    mapping(address => uint256) public addressToId;


    constructor()

    {}    

    function _beforeProofSubmit(
        uint64, /* requestId */
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal view override {
        // check that challenge input of the proof is equal to the msg.sender 
        address addr = GenesisUtils.int256ToAddress(
            inputs[validator.getChallengeInputIndex()]
        );
        require(
            _msgSender() == addr,
            "address in proof is not a sender address"
        );
    }

    function _afterProofSubmit(
        uint64 requestId,
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal override {
        require(
            requestId == TRANSFER_REQUEST_ID && addressToId[_msgSender()] == 0,
            "proof can not be submitted more than once"
        );

        uint256 id = inputs[validator.getChallengeInputIndex()];
        // execute the airdrop
        if (idToAddress[id] == address(0)) {
            addressToId[_msgSender()] = id;
            idToAddress[id] = _msgSender();
        }
    }

    function isEnabledToBorrow(
        uint64 checkId
    ) internal view override returns (bool){       
            return proofs[msg.sender][checkId];
    }

      function isEnabledToBorrowMock(
        uint64 checkId
    ) internal view override returns (bool){       
            return true;
    }
}