// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library PulpLibrary {
   struct Lender {
        uint256 ageThreshold;
        uint256 reputationThreshold;
        address lender;
    }

    struct Borrower {
        bool ageThresholdMet;
        bool reputationThresholdMet;
        address borrower;
    }

    struct Agreement {
        address lenderAddress;
        address borrowerAddress;
        uint256 currentRepaymentAmount;
        uint256 principalBorrowAmount;
        uint256 interestRate;
        uint256 repayByTimestamp;
        uint256 createdDate;
        Lender lenderData;
        Borrower borrowerData;
    }

    struct Offer {
        uint256 ageThreshold;
        uint256 reputationThreshold;
        uint256 loanOfferAmount;
        uint256 interestRate;
        address lender;
    }
}
