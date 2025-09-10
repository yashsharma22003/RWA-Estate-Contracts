// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IIdFactory} from "../lib/solidity/contracts/factory/IIdFactory.sol";

contract configureIdFactory is Script {
    // 1. SET YOUR ADDRESSES HERE
    // =================================================================
    // The address of the deployed TREXImplementationAuthority contract
    address public idFactoryAddress = 0x39992CCEAEDB0fa8f4fd3f2FBC5134707635B371;
    IIdFactory public idFactory = IIdFactory(idFactoryAddress);

    address public trexFactoryAddress = 0x19c99c82512E85732d0f9c563E550bea00A04070;

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
