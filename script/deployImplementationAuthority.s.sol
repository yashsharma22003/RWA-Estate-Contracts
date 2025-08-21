//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {TREXImplementationAuthority} from "../lib/ERC-3643/contracts/proxy/authority/TREXImplementationAuthority.sol";

contract deployImplementationAuthority is Script {
    function run() external {
        vm.startBroadcast();
        TREXImplementationAuthority authority = new TREXImplementationAuthority(true,0x0000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000);
        console.log("TREXImplementationAuthority", address(authority));
        vm.stopBroadcast();
    }
}