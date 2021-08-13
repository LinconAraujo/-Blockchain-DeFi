//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Weth is ERC20 {
  constructor() ERC20('Wrapped Ether', 'WETH'){}

  function deposit() external payable {
    _mint(msg.sender, msg.value);
  }

  function withdraw(uint amount) external {
    require(balanceOf(msg.sender) >= amount, 'balance too low');
    _burn(msg.sender, amount);
    payable(msg.sender).transfer(amount);
  }
}