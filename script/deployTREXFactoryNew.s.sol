// File: script/deploy.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {TREXFactoryNew as TREXFactory} from "../lib/ERC-3643/contracts/factory/TREXFactoryNew.sol";
import {TREXDeployer} from "../lib/ERC-3643/contracts/factory/TREXDeployer.sol";

contract DeployAll is Script {
    function run() external {
        // !!! IMPORTANT: Fill in these two addresses before running !!!script/deployTREXFactoryNew.s.sol
        // This should be the address of your deployed and configured TREXImplementationAuthority
        address implementationAuthority = 0x8A791620dd6260079BF849Dc5567aDC3F2FdC318;
        // This should be the address of your deployed IdFactory
        address idFactory = 0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e;

        vm.startBroadcast();

        // 1. Deploy the logic contract
        TREXDeployer deployer = new TREXDeployer();
        console.log("TREXDeployer (logic) deployed to:", address(deployer));

        // 2. Deploy the state contract (factory)
        TREXFactory factory = new TREXFactory(implementationAuthority, idFactory);
        console.log(" TREXFactory (state) deployed to:", address(factory));

        // 3. Link the factory to its logic contract
        factory.setDeployer(address(deployer));
        console.log(" Factory successfully linked to deployer.");

        vm.stopBroadcast();
    }
}