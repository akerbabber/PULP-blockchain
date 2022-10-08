// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library PulpLibrary {
   struct Lender {
        uint256 ageThreshold;
        uint256 reputationThreshold;
        uint256 principalBorrowAmount;
    }

    struct Borrower {
        bool ageThresholdMet;
        bool reputationThresholdMet;
    }

    struct Agreement {
        address lenderAddress;
        address borrowerAddress;
        Lender lenderData;
        Borrower borrowerData;
    }

}
