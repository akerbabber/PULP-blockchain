// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract LoanRequest {
    struct Request {
        bool ageThresholdMet;
        bool reputationThresholdMet;
        uint256 loanRequestAmount;
    }
}
