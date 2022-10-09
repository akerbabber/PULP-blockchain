// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./LoanOffer.sol";
import "./PulpLibrary.sol";
// import "Verification.sol";

contract Match {
    using PulpLibrary for PulpLibrary.Borrower;
    LoanOffer public loanOffer;
    // Verification public verification;

    /** Processes borrower data to verify against open loan offers requirements. Success creates loan agreement.
    * @param address of borrower
    * @param borrower data
    */
    function startMatch(address borrowerAddress, PulpLibrary.Borrower memory borrowerData) public {
        LoanOffer.Offer[] memory allLoanOffers = loanOffer.getLoanOffers();
        
        for(uint256 i = 0; i < allLoanOffers.length; i++){
            if(Verification.verifyRequirements(borrowerAddress, allLoanOffers[i].ageThreshold, allLoanOffers[i].repThreshold)){
                createLoanAgreement(allLoanOffers[i].lenderData, borrowerData, allLoanOffers[i].loanOffer);
                return true;
            }
           return false;
        }
    }
}
