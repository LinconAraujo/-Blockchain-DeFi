const CoinGecko = require("coingecko-api");
const hre = require("hardhat");

const POLL_INTERVAL = 5000;
const CoinGeckoClinet = new CoinGecko();

async function main() {
  const Oracle = await hre.ethers.getContractFactory("Oracle");
  const Consumer = await hre.ethers.getContractFactory("Consumer");

  const [admin, reporter, _] = await web3.eth.getAccounts();

  const oracle = await Oracle.deploy(admin);
  await oracle.deployed();
  await oracle.updateReporter(reporter, true);

  const consumer = await Consumer.deploy(oracle.address);
  await consumer.deployed();

  console.log("Oracle deployed to:", oracle.address);
  console.log("Consumer deployed to:", consumer.address);

  const signers = await ethers.getSigners();

  while (true) {
    const response = await CoinGeckoClinet.coins.fetch("bitcoin", {});
    let currentPrice = parseFloat(response.data.market_data.current_price.usd);
    currentPrice = parseInt(currentPrice * 100);

    await oracle
      .connect(signers[1])
      .updateData(web3.utils.soliditySha3("BTC/USD"), currentPrice, {
        from: reporter,
      });

    console.log(`new price for BTC/USD ${currentPrice} updated on-chain`);
    await new Promise((resolve) => setTimeout(resolve, POLL_INTERVAL));
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  // .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
