// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IOracle {
    function getPrice(address token) external view returns (uint256 price);
}
