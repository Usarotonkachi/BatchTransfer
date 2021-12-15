const hre = require("hardhat"); //import the hardhat

async function main() {
  const [deployer] = await ethers.getSigners(); //get the account to deploy the contract

  console.log("Deploying contracts with the account:", deployer.address); 
  
  const BatchNFT = await hre.ethers.getContractFactory("BatchNFT"); // Getting the Contract
  
  const batchNFT = await BatchNFT.deploy(); //deploying the contract

  await batchNFT.deployed(); // waiting for the contract to be deployed


  console.log("BatchNFT deployed to:", batchNFT.address); // Returning the contract address on the rinkeby
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); // Calling the function to deploy the contract