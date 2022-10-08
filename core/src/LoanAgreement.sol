// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./PulpLibrary.sol";

contract LoanAgreement {
    using PulpLibrary for PulpLibrary.Lender;
    using PulpLibrary for PulpLibrary.Borrower;
    using PulpLibrary for PulpLibrary.Agreement;

    mapping(address => PulpLibrary.Lender) internal lenderData;
    mapping(address => PulpLibrary.Borrower) internal borrowerData;
    mapping(address => PulpLibrary.Agreement) internal loanAgreements;

    function createLoanAgreement(PulpLibrary.Lender memory lender, PulpLibrary.Borrower memory borrower) public {
        // create loan agreement
    }
    function removeLoanAgreement() public {
        // remove loan agreement
    }

    function updateLoanAgreement() public {
        // update certain loan agreement attributes
    }
    function getLoanAgreement() public returns (PulpLibrary.Agreement memory){
        // get loan agreement
    }

}
