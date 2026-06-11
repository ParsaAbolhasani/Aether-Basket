// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {IUniswapV4Router} from "@uniswap/v4-core/src/interfaces/IUniswapV4Router.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SwapRouter {
    using SafeERC20 for IERC20;

    IUniswapV4Router public router;

    constructor(address _router) {
        router = IUniswapV4Router(_router);
    }

    function swapExactTokensForTokens(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin,
        address recipient
    ) external returns (uint256 amountOut) {
        IERC20(tokenIn).safeTransferFrom(msg.sender, address(this), amountIn);
        IERC20(tokenIn).safeApprove(address(router), amountIn);

        amountOut = router.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            address(this),
            recipient,
            block.timestamp + 300
        );

        return amountOut;
    }
}
