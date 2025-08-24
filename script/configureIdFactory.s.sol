// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IIdFactory} from "../lib/solidity/contracts/factory/IIdFactory.sol";

contract configureIdFactory is Script {
    // 1. SET YOUR ADDRESSES HERE
    // =================================================================
    // The address of the deployed TREXImplementationAuthority contract
    address public idFactoryAddress = 0x959922bE3CAee4b8Cd9a407cc3ac1C251C2007B1;
    IIdFactory public idFactory = IIdFactory(idFactoryAddress);

    address public trexFactoryAddress = 0x9A9f2CCfdE556A7E9Ff0848998Aa4a0CFD8863AE;

    function run() external {
        // Ensure you have set the addresses above before running!

        vm.startBroadcast();

        console.log("Setting Token Factory address to:", trexFactoryAddress);  
        idFactory.addTokenFactory(trexFactoryAddress);
        idFactory.isTokenFactory(trexFactoryAddress);
        console.log("Successfully sent transaction to set Token Factory.");

        vm.stopBroadcast();
    }
}
