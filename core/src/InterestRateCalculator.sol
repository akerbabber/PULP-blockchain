// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "solmate/utils/SignedWadMath.sol";
import "solmate/utils/FixedPointMathLib.sol";

contract InterestRateCalculator {
    using FixedPointMathLib for FixedPointMathLib.rpow;

    function accrueInterest(uint256 _principalAmount, uint256 _rate, uint256 ageSince) internal returns (uint256){
        return wadMul(_principalAmount, FixedPointMathLib.rpow(_rate, ageSince));
    }
}
