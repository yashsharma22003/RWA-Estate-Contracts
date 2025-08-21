//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";

import {TrustedIssuersRegistry} from "../lib/ERC-3643/contracts/registry/implementation/TrustedIssuersRegistry.sol";
import {ClaimTopicsRegistry} from "../lib/ERC-3643/contracts/registry/implementation/ClaimTopicsRegistry.sol";
import {IdentityRegistry} from "../lib/ERC-3643/contracts/registry/implementation/IdentityRegistry.sol";
import {IdentityRegistryStorage} from "../lib/ERC-3643/contracts/registry/implementation/IdentityRegistryStorage.sol";
import {ModularCompliance} from "../lib/ERC-3643/contracts/compliance/modular/ModularCompliance.sol";
import {Token} from "../lib/ERC-3643/contracts/token/Token.sol";

contract deployImplementations is Script {
    function run() external {
        vm.startBroadcast();

        TrustedIssuersRegistry trustedIssuersRegistry = new TrustedIssuersRegistry();
        ClaimTopicsRegistry claimTopicsRegistry = new ClaimTopicsRegistry();
        IdentityRegistry identityRegistry = new IdentityRegistry();
        IdentityRegistryStorage identityRegistryStorage = new IdentityRegistryStorage();
        ModularCompliance modularCompliance = new ModularCompliance();
        Token token = new Token();
        console.log("token", address(token));
        console.log("claimTopicsRegistry", address(claimTopicsRegistry));

        console.log("identityRegistry", address(identityRegistry));
        console.log(
            "identityRegistryStorage",
            address(identityRegistryStorage)
        );
        console.log("trustedIssuersRegistry", address(trustedIssuersRegistry));
        console.log("modularCompliance", address(modularCompliance));

        vm.stopBroadcast();
    }
}
