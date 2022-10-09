// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "solmate/utils/ReentrancyGuard.sol";
import "./PulpLibrary.sol";
import "./LoanAgreement.sol";
import "./InterestRateCalculator.sol";

contract Action is ReentrancyGuard, InterestRateCalculator, LoanAgreement {
    
    using PulpLibrary for PulpLibrary.Agreement;

    event Deposit(address indexed lenderAddress, address indexed receiverAddress, uint256 amount, uint256 timestamp);
    event Borrow(address indexed lenderAddress, address indexed borrowerAddress, uint256 amount, PulpLibrary.Agreement loanAgreement, uint256 timestamp);
    event Repay(address indexed lenderAddress, address indexed borrowerAddress, uint256 amount, PulpLibrary.Agreement loanAgreement, uint256 timestamp);

    receive() external payable {}

    function deposit(address _lenderAddress, uint256 amount) public payable nonReentrant{
        address payable lenderAddress = payable(_lenderAddress);
        (bool sent, ) = lenderAddress.call{value: amount}("");
        require(sent, "Transfer failed");
        emit Deposit(lenderAddress, address(this), amount, block.timestamp);
    }

    function borrow(address borrowerAddress, address lenderAddress, PulpLibrary.Agreement memory loanAgreement) public payable nonReentrant{
        uint256 borrowAmount = loanAgreement.principalBorrowAmount;
        (bool sent, ) = lenderAddress.call{value: borrowAmount}("");
        require(sent, "Transfer failed");
        emit Borrow(lenderAddress, borrowerAddress, borrowAmount, loanAgreement, block.timestamp);
    }

    function repay(address borrowerAddress, address lenderAddress, PulpLibrary.Agreement memory loanAgreement) public payable nonReentrant{
        uint256 repaymentAmount = loanAgreement.currentRepaymentAmount;
        uint256 accruedInterest = uint256(accrueInterest(repaymentAmount, loanAgreement.interestRate, loanAgreement.repayByTimestamp));
        (bool sent, ) = borrowerAddress.call{value: repaymentAmount + accruedInterest}("");
        require(sent, "Transfer failed");
        removeLoanAgreement(lenderAddress);
        emit Repay(lenderAddress, borrowerAddress, repaymentAmount, loanAgreement, block.timestamp);
    }
}
