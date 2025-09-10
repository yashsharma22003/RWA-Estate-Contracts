// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
// IMPORTANT: Ensure this import path correctly points to your ClaimIssuer contract
import {ClaimIssuer} from "../lib/solidity/contracts/ClaimIssuer.sol";

/**
 * @title DeployClaimIssuer
 * @notice Deploys the official ClaimIssuer contract.
 * @dev The script reads the deployer's private key from the PRIVATE_KEY
 * environment variable. The deployer's public address will be set as the
 * initial management key for the new contract.
 */
contract DeployClaimIssuer is Script {
    function run() external returns (address) {
        // --- 1. Load Private Key from Environment ---
   

        // --- 2. Start Broadcast ---
        // All subsequent transactions will be signed using this private key.
        vm.startBroadcast();

        // --- 3. Deploy Contract ---
        // Derive the public address from the private key to set it as the manager.


        console.log("Deploying ClaimIssuer contract...");
        console.log("  - Deployer & Initial Manager:", msg.sender);

        // Deploy the contract, passing the manager's address to the constructor.
        ClaimIssuer claimIssuer = new ClaimIssuer(msg.sender);

        // --- 4. Stop Broadcast ---
        vm.stopBroadcast();

        // --- 5. Log Results ---
        address deployedAddress = address(claimIssuer);
        console.log("\n ClaimIssuer contract deployed successfully!");
        console.log("  - Contract Address:", deployedAddress);

        return deployedAddress;
    }
}

