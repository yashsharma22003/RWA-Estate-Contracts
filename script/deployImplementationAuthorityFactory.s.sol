//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";

import {IAFactory} from "../lib/ERC-3643/contracts/proxy/authority/IAFactory.sol";

contract deployImplementationAuthorityFactory is Script {
    function run() external {
        vm.startBroadcast();

        IAFactory authorityFactory = new IAFactory(0x0000000000000000000000000000000000000000);
        
        console.log("IAFactory deployed at:", address(authorityFactory));

        vm.stopBroadcast();
    }
}