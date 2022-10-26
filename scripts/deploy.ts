// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

async function main() {
  const signer = (await ethers.getSigners())[0];
  console.log("Deploying contracts with the account:", signer.address);
  const batchTransferContract = await ethers.getContractFactory(
    "BatchTransfer"
  );
  const batchTransfer = await batchTransferContract.deploy();
  await batchTransfer.deployed();
  console.log("BatchTransfer deployed to:", batchTransfer.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
