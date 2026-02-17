# DeFi Protocol Engineering — Workspace

Unified Foundry project for all curriculum exercises (Part 1, Part 2, Part 3).

## Structure

```
workspace/
├── src/
│   ├── part1/          # Solidity, EVM & Modern Tooling exercises
│   │   ├── section1/   # Solidity 0.8.x Modern Features
│   │   ├── section2/   # EVM Changes (EIP-1153, 4844, 7702)
│   │   └── ...
│   ├── part2/          # DeFi Foundations exercises (coming soon)
│   │   ├── module1/    # Token Mechanics
│   │   ├── module2/    # AMMs
│   │   └── ...
│   └── part3/          # Modern DeFi Stack exercises (coming soon)
└── test/
    ├── part1/
    ├── part2/
    └── part3/
```

## Setup

```bash
# Install Foundry (if not already installed)
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Install dependencies (run from the workspace directory)
cd workspace
git init   # needed if not already a git repo
forge install foundry-rs/forge-std
```

## How It Works

Each exercise has two files:

| File | Role |
|------|------|
| `src/partN/sectionN/Exercise.sol` | **Scaffold** — types, signatures, and TODO comments. You fill in the implementations. |
| `test/partN/sectionN/Exercise.t.sol` | **Tests** — pre-written, complete. They verify your implementation is correct. |

**Workflow:**
1. Read the scaffold file and the corresponding curriculum section
2. Fill in each `// TODO` block
3. Run `forge test` — when all tests pass, the exercise is complete

**Note:** Some tests pass before you implement anything — this is by design.
Baseline tests prove the vulnerability exists and the vault works for normal use.
For example, in TransientGuard, `test_UnguardedVault_IsVulnerable` shows the
reentrancy attack succeeds without a guard, and `NormalWithdraw` tests confirm
the vault handles legitimate deposits/withdrawals. Your job is to make the
**failing** tests pass (the guard and math tests).

## Running Tests

```bash
# Run all tests
forge test -vvv

# Run all Part 1 tests
forge test --match-path "test/part1/**/*.sol" -vvv

# Run a specific section
forge test --match-path "test/part1/section1/*.sol" -vvv

# Run a specific exercise
forge test --match-contract ShareMathTest -vvv
forge test --match-contract TransientGuardTest -vvv
```

## Current Exercises

### Part 1: Solidity, EVM & Modern Tooling

#### Section 1: Solidity 0.8.x Modern Features

| Exercise | Scaffold | Tests | Concepts |
|----------|----------|-------|----------|
| Day 1: Vault Share Calculator | `src/part1/section1/ShareMath.sol` | `test/part1/section1/ShareMath.t.sol` | UDVTs, custom operators, free functions, unchecked, custom errors, abi.encodeCall |
| Day 2: Transient Reentrancy Guard | `src/part1/section1/TransientGuard.sol` | `test/part1/section1/TransientGuard.t.sol` | transient keyword, tstore/tload assembly, modifier patterns, gas comparison |

#### Section 2: EVM-Level Changes (EIP-1153, EIP-4844, EIP-7702)

| Exercise | Scaffold | Tests | Concepts |
|----------|----------|-------|----------|
| Day 3: Flash Accounting | `src/part1/section2/FlashAccounting.sol` | `test/part1/section2/FlashAccounting.t.sol` | transient storage deep dive, tstore/tload assembly, Uniswap V4 pattern, delta accounting, settlement |
| Day 4: EIP-7702 Delegation | `src/part1/section2/EIP7702Delegate.sol` | `test/part1/section2/EIP7702Delegate.t.sol` | EOA delegation, DELEGATECALL semantics, batching, EIP-1271 signature validation, account abstraction |

#### Section 3: Modern Token Approvals (EIP-2612, Permit2)

| Exercise | Scaffold | Tests | Concepts |
|----------|----------|-------|----------|
| Day 5: EIP-2612 Permit Vault | `src/part1/section3/PermitVault.sol` | `test/part1/section3/PermitVault.t.sol` | EIP-2612 permit, EIP-712 signatures, single-tx deposits, nonce management, vm.sign() testing |
| Day 6-7: Permit2 Integration | `src/part1/section3/Permit2Vault.sol` | `test/part1/section3/Permit2Vault.t.sol` | Permit2 contract, SignatureTransfer, AllowanceTransfer, witness data, mainnet fork testing |
| Day 7: Safe Permit Wrapper | `src/part1/section3/SafePermit.sol` | `test/part1/section3/SafePermit.t.sol` | Front-running protection, try/catch patterns, non-EIP-2612 fallback, defensive programming |

#### Section 4: Account Abstraction (ERC-4337)

| Exercise | Scaffold | Tests | Concepts |
|----------|----------|-------|----------|
| Day 8: Simple Smart Account | `src/part1/section4/SimpleSmartAccount.sol` | `test/part1/section4/SimpleSmartAccount.t.sol` | IAccount interface, validateUserOp, ECDSA validation, UserOperation flow, EntryPoint integration |
| Day 9: EIP-1271 Support | `src/part1/section4/SmartAccountEIP1271.sol` | `test/part1/section4/SmartAccountEIP1271.t.sol` | Contract signature verification, isValidSignature, smart account + DeFi integration |
| Day 10: Paymasters | `src/part1/section4/Paymasters.sol` | `test/part1/section4/Paymasters.t.sol` | VerifyingPaymaster, ERC20Paymaster, gas abstraction, validatePaymasterUserOp, postOp accounting |

#### Section 5: Foundry Workflow & Testing

| Exercise | Scaffold | Tests | Concepts |
|----------|----------|-------|----------|
| Day 11: Base Test Setup | `test/part1/section5/BaseTest.sol` | `test/part1/section5/BaseTest.t.sol` | Abstract base test, mainnet fork, test users, helper functions, labels |
| Day 11: Uniswap V2 Fork | N/A | `test/part1/section5/UniswapV2Fork.t.sol` | Reading reserves, swap calculations, token order, price impact |
| Day 11: Chainlink Fork | N/A | `test/part1/section5/ChainlinkFork.t.sol` | Price feeds, staleness checks, historical data, derived prices |
| Day 12: Simple Vault | `src/part1/section5/SimpleVault.sol` | `test/part1/section5/SimpleVault.t.sol` | ERC-4626 pattern, shares/assets conversion, fuzz testing with bound() |
| Day 12: Vault Handler | `test/part1/section5/VaultHandler.sol` | N/A | Handler pattern, ghost variables, actor management, constraining fuzzer |
| Day 12: Vault Invariants | N/A | `test/part1/section5/VaultInvariant.t.sol` | Invariant testing, solvency checks, conservation laws, targetContract |
| Day 13: Uniswap Swap Fork | N/A | `test/part1/section5/UniswapSwapFork.t.sol` | Full swap workflow, slippage protection, multi-hop swaps, price impact |
| Day 13: Gas Optimization | `src/part1/section5/GasOptimization.sol` | `test/part1/section5/GasOptimization.t.sol` | Custom errors, storage packing, calldata vs memory, unchecked, loop optimization |
| Day 13: Deployment Script | `script/DeploySimpleVault.s.sol` | N/A | Foundry scripts, vm.broadcast, env variables, multi-contract deployment |

#### Section 6: Proxy Patterns & Upgradeability

| Exercise | Scaffold | Tests | Concepts |
|----------|----------|-------|----------|
| Day 14-15: UUPS Vault | `src/part1/section6/UUPSVault.sol` | `test/part1/section6/UUPSVault.t.sol` | UUPS pattern, V1→V2 upgrade, _authorizeUpgrade, storage persistence, reinitializer |
| Day 15: Uninitialized Proxy | `src/part1/section6/UninitializedProxy.sol` | `test/part1/section6/UninitializedProxy.t.sol` | Proxy attack vectors, initializer modifier, _disableInitializers, reinitializer(n) |
| Day 15: Storage Collision | `src/part1/section6/StorageCollision.sol` | `test/part1/section6/StorageCollision.t.sol` | Storage layout compatibility, append-only upgrades, storage gaps, forge inspect |
| Day 15: Beacon Proxy | `src/part1/section6/BeaconProxy.sol` | `test/part1/section6/BeaconProxy.t.sol` | Beacon pattern, multi-proxy upgrades, Aave aToken pattern, shared implementation |
