//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";

import {ITREXImplementationAuthority} from "../lib/ERC-3643/contracts/proxy/authority/ITREXImplementationAuthority.sol";

contract configureImplementationAuthority is Script {

    address public implementationAuthorityAddress = 0x0165878A594ca255338adfa4d48449f69242Eb8F;
   
    
    ITREXImplementationAuthority.TREXContracts public trexcontracts = ITREXImplementationAuthority.TREXContracts({
        tokenImplementation: 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707,
        ctrImplementation: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512,
        irImplementation: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0,
        irsImplementation: 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9,
        tirImplementation: 0x5FbDB2315678afecb367f032d93F642f64180aa3,
        mcImplementation: 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9
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
