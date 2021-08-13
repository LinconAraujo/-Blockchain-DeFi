import "@nomiclabs/hardhat-web3";
import "@nomiclabs/hardhat-waffle";

const config = {
  solidity: "0.8.3",
  networks: {
    hardhat: {
      inject: false,
    },
  },
  namedAccounts: {
    deployer: 0,
  },
};

export default config;
