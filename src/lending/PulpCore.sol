// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./LoanAgreement.sol";
import "./LoanOffer.sol";
import "./Action.sol";
import "./Match.sol";
import "./PulpLibrary.sol";

contract PulpCore is LoanOffer, Match {
    using PulpLibrary for PulpLibrary.Borrower;
    using PulpLibrary for PulpLibrary.Lender;

    uint256 public constant MAX_LOAN_AMOUNT = 10000;
    uint256 public constant DEFAULT_INTEREST_RATE = 15;

    uint64[6] private requirementIds = [
        1, // Age Check ID
        2, // Credit Check ID
        3, // GPA Check ID
        4, // SheFI ID
        5, // Bankless ID
        6  // Income ID
        ];

    modifier moreThanMaxAmount(uint256 requestedLoanAmount){
        require(requestedLoanAmount <= 10000, "Requested loan amount is greater than 10,000");
        _;
    }

    constructor() {}

    function initiateLender(uint64[] memory _requirementIds, uint256 _loanOfferAmount, uint256 _interestRate) public {
        address lenderAddress = msg.sender;
        PulpLibrary.Offer memory newLoanOffer = PulpLibrary.Offer({
            loanOfferAmount: _loanOfferAmount, 
            interestRate: _interestRate, 
            lender: lenderAddress,
            requirementIds: _requirementIds
        });
        addLoanOffer(newLoanOffer);
    }
    
    function initiateBorrower() public {
        address borrowerAddress = msg.sender;
        PulpLibrary.Borrower memory newBorrower = PulpLibrary.Borrower({
            borrower: borrowerAddress,
            requirementsMet: false
        });

        startMatch(borrowerAddress, newBorrower);
    }

}
