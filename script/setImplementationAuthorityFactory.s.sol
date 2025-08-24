// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ITREXImplementationAuthority} from "../lib/ERC-3643/contracts/proxy/authority/ITREXImplementationAuthority.sol";

contract setImplementationAuthorityFactory is Script {
    // 1. SET YOUR ADDRESSES HERE
    // =================================================================
    // The address of the deployed TREXImplementationAuthority contract
    address public authorityAddress = 0x0165878A594ca255338adfa4d48449f69242Eb8F;

    // The address of the IA Factory contract you want to link
    address public iaFactoryAddress = 0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6;
    // =================================================================

    address public trexFactoryAddress = 0x9A9f2CCfdE556A7E9Ff0848998Aa4a0CFD8863AE;

    function run() external {
        // Ensure you have set the addresses above before running!
    
        vm.startBroadcast();

        ITREXImplementationAuthority authority = ITREXImplementationAuthority(authorityAddress);

        console.log("Target TREXImplementationAuthority:", authorityAddress);
        console.log("Setting IA Factory address to:", iaFactoryAddress);

        // Call the setIAFactory function
        authority.setIAFactory(iaFactoryAddress);

        console.log("Successfully sent transaction to set IA Factory.");

        vm.stopBroadcast();
    }
}
