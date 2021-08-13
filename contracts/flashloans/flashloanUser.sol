//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './flashloan.sol';
import './iFlashloanUser.sol';

contract FlashloanUser is iFlashloanUser {
  function startFlashloan(
    address flashloan,
    uint amount,
    address token
  ) external {
    FlashloanProvider(flashloan).executeFlashloan(address(this), amount, token, bytes(''));
  }

  function flashloanCallback(uint amount, address token, bytes memory data) override external {
    // do some arbitrage, liquidation, etc...

    // Reimburse borrowed tokens
    IERC20(token).transfer(msg.sender, amount);
  }
}