//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IOracle {
  function getDate(bytes32 key) external view returns(bool result, uint date, uint payload); 
}