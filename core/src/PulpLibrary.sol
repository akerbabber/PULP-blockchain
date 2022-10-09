// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library PulpLibrary {
   struct Lender {
        uint256 ageThreshold;
        uint256 reputationThreshold;
    }

    struct Borrower {
        bool ageThresholdMet;
        bool reputationThresholdMet;
    }

    struct Agreement {
        address lenderAddress;
        address borrowerAddress;
        uint256 currentRepaymentAmount;
        uint256 principalBorrowAmount;
        Lender lenderData;
        Borrower borrowerData;
    }
    
    struct Offer {
        uint256 ageThreshold;
        uint256 reputationThreshold;
        uint256 loanOfferAmount;
    }
}
