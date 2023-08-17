import { ethers } from "hardhat";
const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const EnergyTrading = await hre.ethers.getContractFactory("EnergyTrading");
  const energyTrading = await EnergyTrading.deploy();

  await energyTrading.deployed();

  console.log("EnergyTrading deployed to:", energyTrading.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
