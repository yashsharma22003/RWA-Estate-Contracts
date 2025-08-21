//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

//libraries

import {TrustedIssuersRegistry} from "../lib/ERC-3643/contracts/registry/implementation/TrustedIssuersRegistry.sol";
import {ClaimTopicsRegistry} from "../lib/ERC-3643/contracts/registry/implementation/ClaimTopicsRegistry.sol";
import {IdentityRegistry} from "../lib/ERC-3643/contracts/registry/implementation/IdentityRegistry.sol";
import {IdentityRegistryStorage} from "../lib/ERC-3643/contracts/registry/implementation/IdentityRegistryStorage.sol";
import {ModularCompliance} from "../lib/ERC-3643/contracts/compliance/modular/ModularCompliance.sol";
import {Token} from "../lib/ERC-3643/contracts/token/Token.sol";

//authority

import {TREXImplementationAuthority} from "../lib/ERC-3643/contracts/proxy/authority/TREXImplementationAuthority.sol";

//factory

import {TREXFactory} from "../lib/ERC-3643/contracts/factory/TREXFactory.sol";
import {IAFactory} from "../lib/ERC-3643/contracts/proxy/authority/IAFactory.sol";

