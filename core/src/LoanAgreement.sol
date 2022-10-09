// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./PulpLibrary.sol";

contract LoanAgreement {
    using PulpLibrary for PulpLibrary.Lender;
    using PulpLibrary for PulpLibrary.Borrower;
    using PulpLibrary for PulpLibrary.Agreement;
    using PulpLibrary for PulpLibrary.Offer;

    uint256 public constant DEFAULT_EXPIRATION_TIMESPAN = 2629800;

    mapping(address => PulpLibrary.Lender) internal lenderData;
    mapping(address => PulpLibrary.Borrower) internal borrowerData;
    mapping(address => PulpLibrary.Agreement) internal loanAgreements;

    modifier alreadyInAgreement(address _borrowerAddress, address _lenderAddress){
        require(loanAgreements[_borrowerAddress].lenderAddress != _lenderAddress, "Already in loan agreement with this lender.");
        _;
    }

    function createLoanAgreement(PulpLibrary.Lender memory lender, PulpLibrary.Borrower memory borrower, PulpLibrary.Offer memory lenderOffer) public alreadyInAgreement(borrower.borrower, lender.lender){
        uint256 monthFromTimestamp = block.timestamp + DEFAULT_EXPIRATION_TIMESPAN;

        PulpLibrary.Agreement memory newAgreement = PulpLibrary.Agreement({
            lenderAddress: lender.lender,
            borrowerAddress: borrower.borrower, 
            currentRepaymentAmount: lenderOffer.loanOfferAmount, 
            principalBorrowAmount: lenderOffer.loanOfferAmount, 
            repayByTimestamp: monthFromTimestamp, 
            createdDate: block.timestamp, 
            lenderData: lender, 
            borrowerData: borrower
        });

        loanAgreements[lender.lender] = newAgreement;

    }
    function removeLoanAgreement(address lenderAddress) public {
        delete loanAgreements[lenderAddress];
    }

    function updateLoanAgreement() public {
    }
    
    function getLoanAgreement(address borrowerAddress) public view returns (PulpLibrary.Agreement memory){
        return loanAgreements[borrowerAddress];
    }

}
