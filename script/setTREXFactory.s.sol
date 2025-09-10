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


    address public trexFactoryAddress = 0x19c99c82512E85732d0f9c563E550bea00A04070;

    function run() external {
        // Ensure you have set the addresses above before running!

        vm.startBroadcast();

        ITREXImplementationAuthority authority = ITREXImplementationAuthority(authorityAddress);

        console.log("Target TREXImplementationAuthority:", authorityAddress);

        authority.setTREXFactory(trexFactoryAddress);


        console.log("TREXFactory address set in TREXImplementationAuthority:", trexFactoryAddress);

        vm.stopBroadcast();
    }
}
