//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IFlashloanUser {
  function flashloanCallback(uint amount, address token, bytes memory data) external;
}