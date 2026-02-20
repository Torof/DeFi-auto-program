// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @notice ERC-20 that takes a 1% fee on every transfer.
/// @dev The fee is burned (removed from circulation).
///      This simulates tokens like STA, PAXG, safemoon-style tokens.
///      If a vault naively credits `amount` instead of measuring what it received,
///      accounting breaks — users can withdraw more than the vault holds.
contract FeeOnTransferToken is ERC20 {
    uint256 public constant FEE_BPS = 100; // 1%

    constructor() ERC20("FeeToken", "FEE") {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        uint256 fee = (amount * FEE_BPS) / 10_000;
        _burn(msg.sender, fee);
        return super.transfer(to, amount - fee);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        uint256 fee = (amount * FEE_BPS) / 10_000;
        // Spend allowance on the full amount (fee is deducted from sender's balance)
        _spendAllowance(from, msg.sender, amount);
        _burn(from, fee);
        _transfer(from, to, amount - fee);
        return true;
    }
}
