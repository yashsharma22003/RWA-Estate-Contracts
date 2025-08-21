## Deployments (Local)

  token 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707
  claimTopicsRegistry 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
  identityRegistry 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
  identityRegistryStorage 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
  trustedIssuersRegistry 0x5FbDB2315678afecb367f032d93F642f64180aa3
  modularCompliance 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9
  

TREXImplementationAuthority 0x0165878A594ca255338adfa4d48449f69242Eb8F

IAFactory deployed at: 0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6

TREXDeployer (logic) deployed to: 0x8A791620dd6260079BF849Dc5567aDC3F2FdC318
TREXFactory (state) deployed to: 0x610178dA211FEF7D417bC0e6FeD39F05609AD788

## Deploymeny Steps

forge script script/deployImplementations.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge script script/deployImplementationAuthority.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge script script/configureImplementationAuthority.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbe
d5efcae784d7bf4f2ff80

forge script script/deployImplementationAuthorityFactory.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge script script/deployTREXFactoryNew.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge script script/setTREXFactory.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge script script/setImplementationAuthorityFactory.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

forge script script/setupTREXSuite.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80