# 🧺 AetherBasket – Smart Contracts

### Production-Grade DeFi Smart Contract Suite for Automated Portfolio Rebalancing

[![Solidity](https://img.shields.io/badge/Solidity-0.8.25-black)](https://soliditylang.org/)
[![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FF69B4)](https://getfoundry.sh/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Tests](https://img.shields.io/badge/Tests-Fuzz%20%26%20Invariant-brightgreen)]()
[![Chainlink](https://img.shields.io/badge/Oracle-Chainlink-blue)](https://chain.link/)
[![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-v5.0-blue)](https://openzeppelin.com/)

---

## 📌 Overview

**AetherBasket** is a **production-ready, modular DeFi protocol** that allows users to create and manage custom token baskets with automatic rebalancing. This repository contains the **smart contract core** built with Foundry.

The protocol enables:

- 🧺 **Custom Basket Creation** – Define a portfolio of ERC-20 tokens with target percentages
- 🔄 **Automated Rebalancing** – Keep your portfolio aligned with target allocations
- 💰 **Single-Asset Deposits/Withdrawals** – Deposit one token, receive basket shares
- 📊 **Chainlink Oracle Integration** – Real-time price feeds for accurate valuations
- 🛡️ **Enterprise-Grade Security** – ReentrancyGuard, Ownable, SafeERC20
- ⛽ **Gas Optimized** – Factory pattern (EIP-1167) for cheap basket deployment


---

## 📁 Contract Inventory

| Contract | Description | Key Features |
|----------|-------------|--------------|
| **Basket** | Core portfolio contract | Asset management, rebalancing, deposit/withdraw |
| **BasketFactory** | Factory for deploying baskets | EIP-1167 minimal proxies, ownership management |
| **IOracle** | Price feed interface | Chainlink AggregatorV3 integration |
| **IBasket** | Basket interface | Standardized interaction methods |

---

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| **Language** | Solidity 0.8.25 |
| **Framework** | Foundry (Forge, Cast, Anvil) |
| **Libraries** | OpenZeppelin v5.0, Chainlink Contracts |
| **Testing** | Forge (Fuzz, Invariant, Unit tests) |
| **Oracle** | Chainlink Price Feeds |
| **DEX** | Uniswap V4 (planned) |

---

## 🚀 Quick Start

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Git


forge test --match-test "Fuzz"


🧪 Testing Strategy
Unit Tests
Individual function correctness
Edge case handling (zero amounts, invalid percentages)
Access control (onlyOwner)

Fuzz Tests
Random asset count (2-20 tokens)
Random target percentages (sum = 100%)
Random deposit amounts
Random rebalance triggers

Invariant Tests
Total value locked never decreases without withdrawal
Sum of target percentages always = 100%
Oracle price always > 0

📊 Coverage


File	Lines	Functions	Branches
Basket.sol	92%	100%	88%
BasketFactory.sol	98%	100%	95%
Oracle.sol	100%	100%	100%
Total	95%+	100%	91%

🔧 Environment Variables

# RPC URLs
MAINNET_RPC_URL=https://eth-mainnet.g.alchemy.com/v2/YOUR_KEY
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_KEY
# Private key (for deployment)
DEPLOYER_PRIVATE_KEY=your_private_key
# Etherscan API key (for verification)
ETHERSCAN_API_KEY=your_api_key

🚢 Deployment
Deploy to Sepolia Testnet

# Set environment
source .env
# Deploy Oracle first
forge script script/DeployOracle.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
# Deploy Factory
forge script script/DeployFactory.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify

📝 Scripts

# Create a new basket
cast send $FACTORY_ADDRESS "createBasket(address[],uint256[])" "[0xtoken1,0xtoken2]" "[5000,5000]" --rpc-url $RPC_URL --private-key $PRIVATE_KEY
# Deposit into basket
cast send $BASKET_ADDRESS "deposit(uint256,uint256)" 1e18 0.95e18 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
# Get current allocations
cast call $BASKET_ADDRESS "getCurrentAllocations()(uint256[])" --rpc-url $RPC_URL
# Trigger rebalance
cast send $BASKET_ADDRESS "rebalance()" --rpc-url $RPC_URL --private-key $PRIVATE_KEY

🔐 Security
Measure	Implementation
Reentrancy	ReentrancyGuard on all state-changing functions
Access Control	Ownable for admin functions
Token Safety	SafeERC20 for all token transfers
Oracle Fallback	Circuit breaker for price feed failures
Slippage Protection	minAmountOut/minAmountsIn parameters
Emergency Pause	Pausable mechanism (planned)

Audits
✅ Internal fuzz testing completed
⏳ Formal verification (planned)
⏳ External audit (Q3 2026)

🧠 Next Features
Uniswap V4 integration for rebalancing swaps
AI agent for optimal rebalancing timing
Flash loan protection
Gas optimization with EIP-2535 (Diamond Proxy)
Subgraph for event indexing
Frontend dashboard

🤝 Contributing
Fork the repository
Create a feature branch (git checkout -b feature/amazing)
Run tests (forge test)
Commit changes (git commit -m 'Add amazing feature')
Push (git push origin feature/amazing)
Open Pull Request
📄 License
MIT © 2026 Parsa Abolhasani Rad

👨‍💻 Author
Parsa Abolhasani Rad – Senior Blockchain Engineer
🔗 www.linkedin.com/in/parsa-abolhasani-rad-
💻 https://github.com/ParsaAbolhasani
✉️ parsaabolhasani9@gmail.com

⭐ Show Your Support
If AetherBasket helps you learn or build, please give it a ⭐ on GitHub!

Built with ❤️ and ⚡ by Parsa Abolhasani Rad
