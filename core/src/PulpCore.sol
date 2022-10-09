// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PulpCore {
    uint256 public constant MAX_LOAN_AMOUNT = 10000;
    uint256 public constant DEFAULT_INTEREST_RATE = 15;

    modifier moreThanMaxAmount(uint256 requestedLoanAmount){
        require(requestedLoanAmount <= 10000, "Requested loan amount is greater than 10,000");
        _;
    }

    constructor() {}
}
