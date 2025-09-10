// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

// We can use the IIdentity interface because ClaimIssuer inherits its functions like addKey
import {IIdentity} from "../lib/solidity/contracts/interface/IIdentity.sol";

/**
 * @title ConfigureClaimIssuer
 * @notice Configures the deployed ClaimIssuer contract by adding a CLAIM key.
 * @dev This script must be run once after deploying the ClaimIssuer. It grants the
 * admin wallet (specified by PRIVATE_KEY) the permission to sign claims (purpose 3),
 * which is required for the isClaimValid check to pass.
 */
contract ConfigureClaimIssuer is Script {
    // Define constants for clarity
    uint256 private constant CLAIM_PURPOSE = 3;
    uint256 private constant KEY_TYPE_ECDSA = 1;

    function run() external {
        // --- 1. Load Environment Variables ---
       
      

        address issuerContractAddress = vm.envAddress("CLAIM_ISSUER_ADDRESS");
        require(issuerContractAddress != address(0), "CLAIM_ISSUER_ADDRESS not set in .env file.");

        // --- 2. Prepare Transaction Data ---
        bytes32 adminKeyHash = keccak256(abi.encode(msg.sender));

        console.log("--- Configuring ClaimIssuer Contract ---");
        console.log("  - Issuer Contract:", issuerContractAddress);
        console.log("  - Admin Wallet to Authorize:", msg.sender);
        console.log("  - Granting Permission: CLAIM_PURPOSE (3)");

        // --- 3. Broadcast Transaction ---
        vm.startBroadcast();

        // Create an instance of the ClaimIssuer contract
        IIdentity claimIssuer = IIdentity(issuerContractAddress);

        // Call addKey to grant the admin wallet CLAIM permission on the issuer contract
        claimIssuer.addKey(adminKeyHash, CLAIM_PURPOSE, KEY_TYPE_ECDSA);

        vm.stopBroadcast();

        console.log("\n Success! The ClaimIssuer is now configured.");
        console.log("   Your admin wallet is authorized to sign claims on its behalf.");
    }
}
