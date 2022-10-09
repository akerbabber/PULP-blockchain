// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Action.sol";

contract LoanOffer is Action {
    struct Offer {
        uint256 ageThreshold;
        uint256 reputationThreshold;
        uint256 loanOfferAmount;
        address lender;
    }

    Offer[] public loanOffers;

    function addLoanOffer(Offer storage _loanOffer) internal {
        loanOffers.push(_loanOffer);
        deposit(_loanOffer.lender, _loanOffer.loanOfferAmount);
    }
    
    function removeLoanOffer() external {
        loanOffers.pop();
    }

    function getLoanOffers() external view returns (Offer[] memory){
        return loanOffers;
    }
}
