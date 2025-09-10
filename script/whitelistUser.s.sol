// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
// Use the interface of your simple module
import {TREXCompliance} from "../lib/ERC-3643/contracts/compliance/modular/modules/TREXCompliance.sol";

/**
 * @title WhitelistUser
 * @notice Whitelists a single user's identity on the configured SimpleWhitelistModule.
 * @dev This is a reusable script that can be run for each new user.
 */
contract WhitelistUser is Script {
    function run() external {
        // --- 1. Load Environment Variables ---
    
        address complianceAddress = 0x711aD193a98f0cef86dA4ad5312092772F39a869;
        // The address of the module you deployed with the configureCompliance script
        address moduleAddress = 0xA5D4D189939E1f8Ac1E8d329273dc345554fCc95;
        // The user's Identity contract address you want to whitelist
        address userIdentityAddress = 0x594524233943AF4F3CFfe5DcFfdA005A6F016bC8;

        require(complianceAddress != address(0), "COMPLIANCE_ADDRESS not set.");
        require(moduleAddress != address(0), "MODULE_ADDRESS not set. Please run the configuration script first.");
        require(userIdentityAddress != address(0), "USER_IDENTITY_ADDRESS not set.");

        // --- 2. Broadcast Transaction ---
        vm.startBroadcast();

        console.log("--- Whitelisting User Identity ---");
        console.log("  - Module Contract:", moduleAddress);
        console.log("  - User's Identity:", userIdentityAddress);

        // Call `whitelistIdentity` on the module contract
        TREXCompliance(moduleAddress).whitelistIdentity(complianceAddress, userIdentityAddress);

        console.log("  - Whitelist transaction sent successfully.");

        vm.stopBroadcast();

        console.log("\n Success! User is now whitelisted and can interact with the token.");
    }
}

