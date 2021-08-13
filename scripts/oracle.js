// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const Consumer = await hre.ethers.getContractFactory("Consumer");
  const Oracle = await hre.ethers.getContractFactory("Oracle");

  const [admin, reporter, _] = await web3.eth.getAccounts();

  const oracle = await Oracle.deploy(admin);
  await oracle.deployed();
  await oracle.updateReporter(reporter, true);

  const consumer = await Consumer.deploy(oracle.address);
  await consumer.deployed();

  console.log("Oracle deployed to:", oracle.address);
  console.log("Consumer deployed to:", consumer.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
