// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ITREXFactory} from "../lib/ERC-3643/contracts/factory/ITREXFactory.sol";

contract DeployTrexSuite is Script {
    // 1. CONFIGURE YOUR DEPLOYMENT
    // =======================================================================================
    // The address of your deployed and configured TREXFactory contract
    address public factoryAddress = 0x610178dA211FEF7D417bC0e6FeD39F05609AD788;

    // A unique salt for this deployment. Change this for each new token you deploy.
    string public salt = "MyTokenSale_01";
    // =======================================================================================

    function run() external {
        require(factoryAddress != address(0), "Error: factoryAddress is not set. Please update the script.");

        vm.startBroadcast();

        ITREXFactory factory = ITREXFactory(factoryAddress);

        // 2. DEFINE TOKEN DETAILS
        // =======================================================================================
        // The address that will own all the deployed contracts
        address tokenOwner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; // Example: Anvil account 0

        // Agents are addresses that can manage identities and token operations
        address[] memory irAgents = new address[](1);
        irAgents[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // Example: Anvil account 1

        address[] memory tokenAgents = new address[](1);
        tokenAgents[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // Example: Anvil account 1

        ITREXFactory.TokenDetails memory tokenDetails = ITREXFactory.TokenDetails({
            owner: tokenOwner,
            name: "My Real World Asset Token",
            symbol: "RWAT",
            decimals: 18,
            irs: address(0), // Set to address(0) to deploy a new IdentityRegistryStorage
            ONCHAINID: address(0), // Set to address(0) to create a new OnchainID for the token
            irAgents: irAgents,
            tokenAgents: tokenAgents,
            complianceModules: new address[](0), // Optional: Add compliance module addresses
            complianceSettings: new bytes[](0)   // Optional: Add settings for compliance modules
        });
        // =======================================================================================


        // 3. DEFINE CLAIM DETAILS
        // =======================================================================================
        // Define the types of claims you want to use (e.g., KYC, accredited investor)
        uint256[] memory claimTopics = new uint256[](1);

        // The addresses of trusted entities that can issue these claims
        address[] memory claimIssuers = new address[](1);
        claimIssuers[0] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; // Example: Anvil account 2

        // Map which issuers can issue which claims
        uint256[][] memory issuerClaims = new uint256[][](1);
        issuerClaims[0] = new uint256[](1);
        issuerClaims[0][0] = claimTopics[0]; // Issuer at index 0 can issue the "KYC" claim

        ITREXFactory.ClaimDetails memory claimDetails = ITREXFactory.ClaimDetails({
            claimTopics: claimTopics,
            issuers: claimIssuers,
            issuerClaims: issuerClaims
        });
        // =======================================================================================

        console.log("Deploying T-REX suite with salt:", salt);
        console.log("Token Owner:", tokenDetails.owner);
        console.log("Factory Address:", address(factory));

        // 4. EXECUTE THE DEPLOYMENT
        // =======================================================================================
        factory.deployTREXSuite(salt, tokenDetails, claimDetails);
        // =======================================================================================

        console.log("\n Successfully sent transaction to deploy the T-REX suite.");
        console.log("Note: To find the addresses of the newly deployed contracts, check the `TREXSuiteDeployed` event logs from this transaction.");

        vm.stopBroadcast();
    }
}
