const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  const EnergyTrading = await hre.ethers.getContractFactory("EnergyTrading");
  const energyTrading = await EnergyTrading.attach(process.env.CONTRACT_ADDRESS);

  // Interact with the contract here
  // For example: Create a trade
  const createTradeTx = await energyTrading.createTrade(deployer.address, 100, hre.ethers.utils.parseEther("0.01"));
  await createTradeTx.wait();

  console.log("Trade created");

  // Execute trade
  const executeTradeTx = await energyTrading.executeTrade(0, { value: hre.ethers.utils.parseEther("0.01") });
  await executeTradeTx.wait();

  console.log("Trade executed");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
