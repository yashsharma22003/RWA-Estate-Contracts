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


    address public trexFactoryAddress = 0x610178dA211FEF7D417bC0e6FeD39F05609AD788;

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
