// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract LoanAgreement {
    struct Lender {
        address lenderAddress;
        uint256 ageThreshold;
        uint256 reputationThreshold;
    }

    struct Borrower {
        address borrowerAddress;
        bool ageThresholdMet;
        bool reputationThresholdMet;
    }

}
