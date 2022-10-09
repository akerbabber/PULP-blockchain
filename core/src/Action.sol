// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./PulpLibrary.sol";
import "../../lib/solmate/src/utils/ReentrancyGuard";

contract Action is ReentrancyGuard {
    
    using PulpLibrary for PulpLibrary.Agreement;

    event Deposit(address indexed lenderAddress, address indexed receiverAddress, uint256 amount, uint256 timestamp);
    event Borrow(address indexed lenderAddress, address indexed borrowerAddress, uint256 amount, PulpLibrary.Agreement loanAgreement, uint256 timestamp);
    event Repay(address indexed lenderAddress, address indexed borrowerAddress, uint256 amount, PulpLibrary.Agreement loanAgreement, uint256 timestamp);

    receive() external payable {}

    function deposit(address _lenderAddress, uint256 amount) external payable nonReentrant{
        address payable lenderAddress = payable(_lenderAddress);
        (bool sent, ) = lenderAddress.call{value: amount}("");
        require(sent, "Transfer failed");
        loanState = LoanState.Funded;
        emit Deposit(lenderAddress, address(this), amount, block.timestamp);
    }

    function borrow(address borrowerAddress, address lenderAddress, PulpLibrary.Agreement memory loanAgreement) external payable nonReentrant{
        uint256 borrowAmount = loanAgreement.principalBorrowAmount;
        (bool sent, ) = lenderAddress.call{value: borrowAmount}("");
        require(sent, "Transfer failed");
        loanState = LoanState.Agreed;
        emit Borrow(lenderAddress, borrowerAddress, borrowAmount, loanAgreement, block.timestamp);
    }

    function repay(address borrowerAddress, address lenderAddress, PulpLibrary.Agreement memory loanAgreement) external payable nonReentrant{
        uint256 repaymentAmount = loanAgreement.currentRepaymentAmount;
        uint256 accruedInterest = accrueInterest(repaymentAmount, lenderOffer.interestRate, loanAgreement);
        (bool sent, ) = borrowerAddress.call{value: repaymentAmount + accruedInterest}("");
        require(sent, "Transfer failed");
        removeLoanAgreedment(lenderAddress);
        emit Repay(lenderAddress, borrowerAddress, repaymentAmount, loanAgreement, block.timestamp);
    }
}
