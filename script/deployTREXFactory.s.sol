//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {TREXFactory} from "../lib/ERC-3643/contracts/factory/TREXFactory.sol";

contract deployTREXFactory is Script {

 address public implementationAuthority = 0x53ACe7307B7dbF39F9fB5876FCfd3ac1fB07471e;
 address public idFactory = 0x39992CCEAEDB0fa8f4fd3f2FBC5134707635B371;

    function run() external {

       



        vm.startBroadcast();

        
        TREXFactory trexFactory = new TREXFactory(implementationAuthority,idFactory);

       
        console.log("TREXFactory deployed at:", address(trexFactory));

        vm.stopBroadcast();
    }
}   