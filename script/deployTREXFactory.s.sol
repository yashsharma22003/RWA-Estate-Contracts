//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {TREXFactory} from "../lib/ERC-3643/contracts/factory/TREXFactory.sol";

contract deployTREXFactory is Script {

 address public implementationAuthority = 0x0165878A594ca255338adfa4d48449f69242Eb8F;
 address public idFactory = 0x959922bE3CAee4b8Cd9a407cc3ac1C251C2007B1;

    function run() external {

       



        vm.startBroadcast();

        
        TREXFactory trexFactory = new TREXFactory(implementationAuthority,idFactory);

       
        console.log("TREXFactory deployed at:", address(trexFactory));

        vm.stopBroadcast();
    }
}   