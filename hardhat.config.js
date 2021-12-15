require("@nomiclabs/hardhat-ethers");
require('dotenv').config();
require("@nomiclabs/hardhat-etherscan");

const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY;
const ALCHEMY_API_KEY = process.env.RINKEBY_PRIVATE_KEY;
const INFURAID = process.env.INFURAID;
const ETHERSCANAPI = process.env.ETHERSCANAPI;

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

task(
  "blockNumber",
  "Prints the current block number",
  async (_, { ethers }) => {
    await ethers.provider.getBlockNumber().then((blockNumber) => {
      console.log("Current block number: " + blockNumber);
    });
  }
);


// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  networks: {
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${INFURAID}`,
      accounts: [`${RINKEBY_PRIVATE_KEY}`]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: `${ETHERSCANAPI}`
  }
};
