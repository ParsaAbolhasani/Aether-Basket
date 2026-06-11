// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Basket} from "./Basket.sol";
import {ChainlinkOracle} from "./oracle/ChainlinkOracle.sol";

contract BasketFactory is Ownable {
    using Clones for address;

    address public implementation;
    ChainlinkOracle public oracle;

    event BasketCreated(address indexed basket, address indexed owner);

    constructor(address _implementation, address _oracle, address _owner) Ownable(_owner) {
        implementation = _implementation;
        oracle = ChainlinkOracle(_oracle);
    }

    function createBasket(
        address[] calldata tokens,
        uint256[] calldata targetPercents
    ) external returns (address) {
        require(tokens.length == targetPercents.length, "Length mismatch");
        
        address basket = implementation.clone();
        Basket(basket).initialize(address(oracle), msg.sender);
        
        for (uint256 i = 0; i < tokens.length; i++) {
            Basket(basket).addAsset(tokens[i], targetPercents[i]);
        }
        
        emit BasketCreated(basket, msg.sender);
        return basket;
    }
}
