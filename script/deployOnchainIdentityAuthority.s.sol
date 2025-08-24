//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {ImplementationAuthority} from "../lib/solidity/contracts/proxy/ImplementationAuthority.sol";
import {Identity} from "../lib/solidity/contracts/Identity.sol";

contract deployOnchainIdentityAuthority is Script {



    function run() external {

       
        vm.startBroadcast();

        Identity id = new Identity(msg.sender, false);
        console.log("Identity deployed at:", address(id));
        ImplementationAuthority iaOnchainId = new ImplementationAuthority(address(id));
        console.log("Onchain ID ImplementationAuthority deployed at:", address(iaOnchainId));
        vm.stopBroadcast();
    }
}   