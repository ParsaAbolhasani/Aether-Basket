// اضافه کردن به Basket.sol
import {SwapRouter} from "./swaps/SwapRouter.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Basket is IBasket, Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    // ... existing code ...

    SwapRouter public swapRouter;

    function setSwapRouter(address _swapRouter) external onlyOwner {
        swapRouter = SwapRouter(_swapRouter);
    }

    function _getTargetAmounts(uint256 totalValue) internal view returns (uint256[] memory targetAmounts) {
        targetAmounts = new uint256[](assets.length);
        for (uint256 i = 0; i < assets.length; i++) {
            uint256 targetValue = (totalValue * assets[i].targetPercent) / 10000;
            uint256 price = _getPrice(address(assets[i].token));
            targetAmounts[i] = (targetValue * 1e18) / price;
        }
        return targetAmounts;
    }

    function rebalance() external nonReentrant onlyOwner {
        uint256 totalValue = _getTotalValueLocked();
        uint256[] memory currentAmounts = getCurrentAllocations();
        uint256[] memory targetAmounts = _getTargetAmounts(totalValue);

        for (uint256 i = 0; i < assets.length; i++) {
            if (currentAmounts[i] > targetAmounts[i]) {
                // فروش مازاد
                uint256 surplus = currentAmounts[i] - targetAmounts[i];
                _swapExactTokensForTokens(
                    address(assets[i].token),
                    address(assets[0].token), // swap to base token
                    surplus,
                    0,
                    address(this)
                );
            }
        }

        // به‌روزرسانی مجدد موجودی‌ها بعد از فروش
        uint256 newTotalValue = _getTotalValueLocked();
        uint256[] memory newTargetAmounts = _getTargetAmounts(newTotalValue);

        for (uint256 i = 0; i < assets.length; i++) {
            uint256 currentBalance = assets[i].token.balanceOf(address(this));
            if (currentBalance < newTargetAmounts[i]) {
                // خرید توکن‌های کمبود
                uint256 deficit = newTargetAmounts[i] - currentBalance;
                _swapExactTokensForTokens(
                    address(assets[0].token), // از base token
                    address(assets[i].token),
                    deficit,
                    0,
                    address(this)
                );
            }
        }

        emit Rebalanced(msg.sender, getCurrentAllocations());
    }

    function _swapExactTokensForTokens(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin,
        address recipient
    ) internal {
        require(address(swapRouter) != address(0), "SwapRouter not set");
        
        IERC20(tokenIn).safeApprove(address(swapRouter), amountIn);
        swapRouter.swapExactTokensForTokens(
            tokenIn,
            tokenOut,
            amountIn,
            amountOutMin,
            recipient
        );
    }
}
