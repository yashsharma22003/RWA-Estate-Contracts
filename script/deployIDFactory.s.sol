//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {IdFactory} from "../lib/solidity/contracts/factory/IdFactory.sol";
contract deployTREXFactory is Script {

 address public implementationAuthority = 0x90Baf8fc42a2d5eCe11152F9CC64E1C733928f23;

    function run() external {

       



        vm.startBroadcast();

        
        IdFactory idFactory = new IdFactory(implementationAuthority);

       
        console.log("IdFactory deployed at:", address(idFactory));

        vm.stopBroadcast();
    }
}   