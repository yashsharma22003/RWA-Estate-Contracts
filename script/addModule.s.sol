// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IModularCompliance} from "../lib/ERC-3643/contracts/compliance/modular/IModularCompliance.sol";
import {TREXCompliance} from "../lib/ERC-3643/contracts/compliance/modular/modules/TREXCompliance.sol";

/**
 * @title ConfigureComplianceSystem
 * @notice Performs the final one-time setup for the compliance system.
 * @dev Deploys the simplified compliance module, adds it to the main hub,
 * and configures it with the Identity Registry.
 */
contract addModule is Script {
    function run() external {
        // --- 1. Load Environment Variables ---
     
        address complianceAddress = 0x1D7763C6C7bc12fc53e6667b17671d911aE6CaEC;
        address identityRegistryAddress = 0xAa7bdF67038D0c8a8F14418eeDBFb965213732Da;

        require(complianceAddress != address(0), "COMPLIANCE_ADDRESS not set.");
        require(identityRegistryAddress != address(0), "IDENTITY_REGISTRY_ADDRESS not set.");

        // --- 2. Broadcast Transactions ---
        vm.startBroadcast();

        console.log("--- Starting One-Time Compliance Setup ---");

        // --- Step A: Deploy the Simplified TREXCompliance Module ---
        console.log("\n[1/3] Deploying the TREXCompliance (SimpleWhitelistModule) contract...");
        TREXCompliance simpleModule = new TREXCompliance();
        address moduleAddress = address(simpleModule);
        console.log("      - IMPORTANT! New Module Deployed at:", moduleAddress);

        // --- Step B: Add the Module to the ModularCompliance Hub ---
        console.log("\n[2/3] Adding the new module to the ModularCompliance hub...");
        IModularCompliance(complianceAddress).addModule(moduleAddress);
        console.log("      - Module successfully added to:", complianceAddress);

        // --- Step C: Configure the Module with the Identity Registry ---
        console.log("\n[3/3] Configuring the new module with the Identity Registry...");
        simpleModule.setIdentityRegistry(complianceAddress, identityRegistryAddress);
        console.log("      - Module is now linked to Identity Registry:", identityRegistryAddress);

        vm.stopBroadcast();

        console.log("\n\n Success! The compliance system is now configured.");
        console.log("   Copy the new module address above and add it to your .env file.");
        console.log("   You can now proceed to whitelist users with the whitelistUser script.");
    }
}

