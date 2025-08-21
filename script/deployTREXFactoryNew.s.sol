// File: script/deploy.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {TREXFactoryNew as TREXFactory} from "../lib/ERC-3643/contracts/factory/TREXFactoryNew.sol";
import {TREXDeployer} from "../lib/ERC-3643/contracts/factory/TREXDeployer.sol";

contract DeployAll is Script {
    function run() external {
        // !!! IMPORTANT: Fill in these two addresses before running !!!
        // This should be the address of your deployed and configured TREXImplementationAuthority
        address implementationAuthority = 0x0165878A594ca255338adfa4d48449f69242Eb8F;
        // This should be the address of your deployed IdFactory
        address idFactory = 0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6;

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