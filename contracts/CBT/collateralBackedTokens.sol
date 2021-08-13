//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract CollateralBackedTokens is ERC20 {
  ERC20 public collateral;
  uint public price = 1;

  constructor(address _collateral) ERC20('Collateral Backed Token', 'CBT') {}

  function deposit(uint collateralAmount) external {
    collateral.transferFrom(msg.sender, address(this), collateralAmount);
    _mint(msg.sender, collateralAmount * price);
  }

  function withdraw(uint tokenAmount) external {
    require(balanceOf(msg.sender) >= tokenAmount, 'balance too low');
    _burn(msg.sender, tokenAmount);
    payable(msg.sender).transfer(tokenAmount);
  }
}