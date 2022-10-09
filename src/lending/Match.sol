// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./LoanOffer.sol";
import "./PulpLibrary.sol";
import "./LoanAgreement.sol";
import "../CredentialsVerifier.sol";

contract Match is LoanAgreement, CredentialsVerifier {
    using PulpLibrary for PulpLibrary.Borrower;
    using PulpLibrary for PulpLibrary.Offer;
    LoanOffer public loanOffer;

    /** Processes borrower data to verify against open loan offers requirements. Success creates loan agreement.
    * @param borrowerAddress of borrower
    * @param borrowerData data
    */
    function startMatch(address borrowerAddress, PulpLibrary.Borrower memory borrowerData) public {
        PulpLibrary.Offer[] memory allLoanOffers = loanOffer.getLoanOffers();
        
        for(uint256 i = 0; i < allLoanOffers.length; i++){
            PulpLibrary.Offer memory currentOffer = allLoanOffers[i];
            if(isEnabledToBorrowMock(1) && isEnabledToBorrowMock(4)){

                PulpLibrary.Lender memory newLender = PulpLibrary.Lender({
                    ageThreshold: currentOffer.ageThreshold,
                    reputationThreshold: currentOffer.reputationThreshold,
                    lender: currentOffer.lender
                });

                createLoanAgreement(newLender, borrowerData, currentOffer);
            }
        }
    }
}
