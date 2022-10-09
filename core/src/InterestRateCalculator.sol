// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../../lib/src/solmate/utils/SignedWadMath.sol";
import "../../lib/src/solmate/utils/FixedPointMathLib.sol";

contract InterestRateCalculator {
    using FixedPointMathLib for FixedPointMathLib.rpow;

    function accrueInterest(uint256 _principalAmount, uint256 _rate, uint256 ageSince) external pure returns (uint256){
        return wadMul(_principalAmount, FixedPointMathLib.rpow(_rate, _age));
    }
}
