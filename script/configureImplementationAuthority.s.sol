//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";

import {ITREXImplementationAuthority} from "../lib/ERC-3643/contracts/proxy/authority/ITREXImplementationAuthority.sol";

contract configureImplementationAuthority is Script {

    address public implementationAuthorityAddress = 0x53ACe7307B7dbF39F9fB5876FCfd3ac1fB07471e;
   
    
    ITREXImplementationAuthority.TREXContracts public trexcontracts = ITREXImplementationAuthority.TREXContracts({
        tokenImplementation: 0x364f24C2D13c0856419DD3E421efA3b41369f802,
        ctrImplementation: 0x6b6f358A8baa55C858ECaaF231C726f445Ddb127,
        irImplementation: 0xB0B0b80A9166a9b7c27E700FfFf6AfCfA8acaC9D,
        irsImplementation: 0x0C59D4D07F39cef27d851FF664b623Ea5976FC8a,
        tirImplementation: 0x7910f8B8Da1a159d6a6A2465468Fa37A9Aac16F4,
        mcImplementation: 0xc56bf22DCE535612D408bd2D4236Cad6EE2c6431
    });

    ITREXImplementationAuthority.Version public trexVersion = ITREXImplementationAuthority.Version({
        major: 1,
        minor: 0,
        patch: 0
    });

    function run() external {
        vm.startBroadcast();
        ITREXImplementationAuthority authority = ITREXImplementationAuthority(implementationAuthorityAddress);
        authority.addAndUseTREXVersion(trexVersion, trexcontracts);

        vm.stopBroadcast();
        console.log("TREXImplementationAuthority configured successfully.");
    }
}
