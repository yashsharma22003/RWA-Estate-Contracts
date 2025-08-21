//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {TREXFactory} from "../lib/ERC-3643/contracts/factory/TREXFactory.sol";

contract deployTREXFactory is Script {

 address public implementationAuthority = 0x0165878A594ca255338adfa4d48449f69242Eb8F;

    function run() external {

       



        vm.startBroadcast();

        
        TREXFactory trexFactory = new TREXFactory(0x0165878A594ca255338adfa4d48449f69242Eb8F,0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6);

       
        console.log("TREXFactory deployed at:", address(trexFactory));

        vm.stopBroadcast();
    }
}   