// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IModularCompliance} from "../lib/ERC-3643/contracts/compliance/modular/IModularCompliance.sol";
// IMPORTANT: This path must point to your simplified module contract
import {TREXCompliance} from "../lib/ERC-3643/contracts/compliance/modular/modules/TREXCompliance.sol";

/**
 * @title ConfigureComplianceSystem
 * @notice Performs the final one-time setup for the compliance system.
 * @dev This script deploys the simplified compliance module, adds it to the main
 * ModularCompliance contract, and configures it with the correct Identity Registry.
 */
contract addComplianceModule is Script {
    function run() external {
        // --- 1. Load Environment Variables ---
        uint256 adminPrivateKey = vm.envUint("PRIVATE_KEY");
        address complianceAddress = vm.envAddress("COMPLIANCE_ADDRESS");
        address identityRegistryAddress = 0xB0B0b80A9166a9b7c27E700FfFf6AfCfA8acaC9D;

        require(adminPrivateKey != 0, "PRIVATE_KEY not set.");
        require(complianceAddress != address(0), "COMPLIANCE_ADDRESS not set.");
        require(identityRegistryAddress != address(0), "IDENTITY_REGISTRY_ADDRESS not set.");

        // --- 2. Broadcast Transactions ---
        vm.startBroadcast(adminPrivateKey);

        console.log("--- Starting Final Compliance Setup ---");

        // --- Step A: Deploy the Simplified TREXCompliance Module ---
        console.log("\n1. Deploying the TREXCompliance (SimpleWhitelistModule) contract...");
        TREXCompliance simpleModule = new TREXCompliance();
        address moduleAddress = address(simpleModule);
        console.log("   - Module Contract Deployed at:", moduleAddress);

        // --- Step B: Add the Module to the ModularCompliance Hub ---
        console.log("\n2. Adding the new module to the ModularCompliance hub...");
        IModularCompliance(complianceAddress).addModule(moduleAddress);
        console.log("   - Module successfully added to:", complianceAddress);

        // --- Step C: Configure the Module with the Identity Registry ---
        console.log("\n3. Configuring the new module with the Identity Registry...");
        simpleModule.setIdentityRegistry(complianceAddress, identityRegistryAddress);
        console.log("   - Module is now linked to Identity Registry:", identityRegistryAddress);

        vm.stopBroadcast();

        console.log("\n\n Success! The compliance system is now fully configured and ready.");
        console.log("   You can now proceed to whitelist users.");
    }
}
