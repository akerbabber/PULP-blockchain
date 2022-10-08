// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract LoanOffer {
    struct Offer {
        uint256 ageThreshold;
        uint256 reputationThreshold;
        uint256 loanOfferAmount;
    }

    Offer[] public loanOffers;

    function addLoanOffer() internal returns (Offer memory) {
        // add all loan offers
    }
    
    function removeLoanOffer() external {
        // done automatically by met requirements
        // triggered by loan user
    }

    function getLoanOffers() external view returns (Offer[] memory){
        // get all loan offers
    }
}
