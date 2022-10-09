// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Action.sol";
import "./PulpLibrary.sol";

contract LoanOffer is Action {
    using PulpLibrary for PulpLibrary.Offer;

    PulpLibrary.Offer[] public loanOffers;

    function addLoanOffer(PulpLibrary.Offer memory _loanOffer) public {
        loanOffers.push(_loanOffer);
        deposit(_loanOffer.lender, _loanOffer.loanOfferAmount);
    }
    
    function removeLoanOffer() external {
        loanOffers.pop();
    }

    function getLoanOffers() external view returns (PulpLibrary.Offer[] memory){
        return loanOffers;
    }
}
