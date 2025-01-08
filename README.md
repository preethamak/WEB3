Decentralized Crowdfunding Platform
This is a blockchain-powered crowdfunding platform that allows creators to launch campaigns with transparency and empowers contributors with complete visibility over their contributions.

🚀 Features
->Seamless Campaign Management: Create and manage crowdfunding campaigns effortlessly.
->Blockchain Transparency: Every transaction is secure and visible on the blockchain.
->Decentralized Control: No middlemen, lower fees, and full user control.
->User-Friendly Interface: Built with React for a smooth user experience.

🛠️ Tech Stack
->Thirdweb SDK: For seamless blockchain integration and deployment.
->Solidity: Custom smart contracts to handle campaign logic securely.
->React: A responsive frontend framework for interacting with the blockchain.


## Getting Started

Create a project using this example:

```bash
npx thirdweb create --contract --template forge-starter
```
You can start editing the page by modifying `contracts/Contract.sol`.

To add functionality to your contracts, you can use the `@thirdweb-dev/contracts` package which provides base contracts and extensions to inherit. The package is already installed with this project. Head to our [Contracts Extensions Docs](https://portal.thirdweb.com/thirdweb-deploy/contract-extensions) to learn more.

## Building the project

After any changes to the contract, run:

```bash
npm run build
# or
yarn build
```

to compile your contracts. This will also detect the [Contracts Extensions Docs](https://portal.thirdweb.com/thirdweb-deploy/contract-extensions) detected on your contract.

## Deploying Contracts

When you're ready to deploy your contracts, just run one of the following command to deploy you're contracts:

```bash
npm run deploy
# or
yarn deploy
```

## Releasing Contracts

If you want to release a version of your contracts publicly, you can use one of the followings command:

```bash
npm run release
# or
yarn release
```


