//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import './iOracle.sol';

contract Consumer {
  IOracle public oracle;

  constructor(address _oracle) {
    oracle = IOracle(_oracle);
  }

  function foo() view external {
    bytes32 key = keccak256(abi.encodePacked(('BTC/USD')));
    (bool result, uint date, uint payload) = oracle.getDate(key);
    require(result == true, 'could not get price');
    require(date >= block.timestamp - 2 minutes, 'price too old');

    payload;
    // do someting with price
  }
}