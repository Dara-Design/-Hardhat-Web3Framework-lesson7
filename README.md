Usage
Deploy:

npx hardhat deploy
Testing

npx hardhat test
Test Coverage

npx hardhat coverage



https://eslint.org/    //ESLint statically analyzes your code to quickly find problems
npm init @eslint/config

What Is Linting?
Linting is the automated checking of your source code for programmatic and stylistic errors. This is done by using a lint tool (otherwise known as linter). A lint tool is a basic static code analyzer.

https://github.com/protofire/solhint  //This is an open source project for linting Solidity code. This project provides both Security and Style Guide validations.

-----------------------------

https://www.npmjs.com/package/@chainlink/contracts
Usage
The solidity smart contracts themselves can be imported via the src directory of @chainlink/contracts:

import '@chainlink/contracts/src/v0.8/AutomationCompatibleInterface.sol';

------------------------------

https://github.com/wighawag/hardhat-deploy

This hardhat plugin adds a mechanism to deploy contracts to any network, keeping track of them and replicating the same environment for testing.

hardhat-deploy allows you to write deploy scripts in the deploy folder. Each of these files that look as follows will be executed in turn when you execute the following task: hardhat --network <networkName> deploy

// deploy/00_deploy_my_contract.js
module.exports = async ({getNamedAccounts, deployments}) => {
  const {deploy} = deployments;
  const {deployer} = await getNamedAccounts();
  await deploy('MyContract', {
    from: deployer,
    args: ['Hello'],
    log: true,
  });
};
module.exports.tags = ['MyContract'];


install:
npm install -D hardhat-deploy
require:
require('hardhat-deploy');

https://github.com/wighawag/hardhat-deploy-ethers

if you use ethers.js we recommend you also install hardhat-deploy-ethers which add extra features to access deployments as ethers contract
npm install --save-dev  @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers ethers
require:
require("@nomiclabs/hardhat-ethers")

---------------------------------------

WHAT IS  MOCKING?
https://stackoverflow.com/questions/2665812/what-is-mocking
https://github.com/aave/aave-v3-core
https://github.com/smartcontractkit/chainlink  //Chainlink expands the capabilities of smart contracts by enabling access to real-world data and off-chain computation while maintaining the security and reliability guarantees inherent to blockchain technology


------------------------------

Solidity style quide
https://docs.soliditylang.org/en/latest/style-guide.html
https://docs.soliditylang.org/en/latest/natspec-format.html
-----------------------------
Refactoring means changing the way your code works

Unit testing:
https://en.wikipedia.org/wiki/Unit_testing


In our code we wanna first  test pieces of our code and than do a staging test
Staging test is a last stop before you deploy to a mainnet

Unit tests are done locally with :
-local hardhat network
-forked hardhat network
 
 Unit test --> FundMe.test.js  (are located in this project)
--------------------------------
 https://github.com/wighawag/hardhat-deploy#creating-fixtures  //tests can easily create efficient fixture using deployments.createFixture

--------------------------------
https://ethereum-waffle.readthedocs.io/en/latest/matchers.html
https://docs.ethers.org/v5/api/utils/display-logic/#utils-parseUnits
