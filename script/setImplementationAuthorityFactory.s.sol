// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ITREXImplementationAuthority} from "../lib/ERC-3643/contracts/proxy/authority/ITREXImplementationAuthority.sol";

contract setImplementationAuthorityFactory is Script {
    // 1. SET YOUR ADDRESSES HERE
    // =================================================================
    // The address of the deployed TREXImplementationAuthority contract
    address public authorityAddress = 0x53ACe7307B7dbF39F9fB5876FCfd3ac1fB07471e;

    // The address of the IA Factory contract you want to link
    address public iaFactoryAddress = 0x3B746CC01bFCe0CE93a82FA49c6Bdde1C3BA550E;
    // =================================================================

    address public trexFactoryAddress = 0x19c99c82512E85732d0f9c563E550bea00A04070;

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
