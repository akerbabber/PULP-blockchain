// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "solmate/utils/SignedWadMath.sol";
import "solmate/utils/FixedPointMathLib.sol";

contract InterestRateCalculator {
    using FixedPointMathLib for uint256;

    function accrueInterest(uint256 _principalAmount, uint256 _rate, uint256 ageSince) internal pure returns (int256){
        int256 principal = int256(_principalAmount);
        int256 exp = int256(FixedPointMathLib.rpow(_rate, ageSince, 1));
        return wadMul(principal, exp);
    }
}
