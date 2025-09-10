// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

// --- Interface Definitions ---
// It's best to import these from the TREX package, but defining them here works too.

interface IIdFactory {
    function createIdentity(address owner) external returns (address);
}

interface IIdentity {
    function addClaim(
        uint256 _topic,
        uint256 _scheme,
        address _issuer,
        bytes calldata _signature,
        bytes calldata _data
    ) external;
}

interface IIdentityRegistry {
    function identity(address _user) external view returns (address);
}

// --- The Onboarding Script ---

contract OnboardUser is Script {
    // Contract addresses from your Mainnet (Polygon Amoy) deployment
    address constant ID_FACTORY_ADDRESS = 0x39992CCEAEDB0fa8f4fd3f2FBC5134707635B371;
    address constant IDENTITY_REGISTRY_ADDRESS = 0xB0B0b80A9166a9b7c27E700FfFf6AfCfA8acaC9D;

    // --- Claim Details ---
    // IMPORTANT: Replace this with the actual topic for KYC from your ClaimTopicsRegistry.
    // This example uses topic '1'.
    uint256 constant KYC_TOPIC = 1;
    uint256 constant ECDSA_SCHEME = 1; // Standard scheme for ECDSA signatures

    function run() external {
        // 1. Load the issuer's private key and the new user's address from environment variables
        uint256 issuerPrivateKey = vm.envUint("ISSUER_PRIVATE_KEY");
        address userAddress = vm.envAddress("USER_TO_ONBOARD");

        if (issuerPrivateKey == 0) {
            revert("ISSUER_PRIVATE_KEY not set in .env file");
        }
        if (userAddress == address(0)) {
            revert("USER_TO_ONBOARD not set in .env file");
        }

        address issuerAddress = vm.addr(issuerPrivateKey);
        console.log("Onboarding User:", userAddress);
        console.log("Using Issuer:", issuerAddress);

        // 2. Get contract instances
        IIdFactory idFactory = IIdFactory(ID_FACTORY_ADDRESS);
        IIdentityRegistry identityRegistry = IIdentityRegistry(IDENTITY_REGISTRY_ADDRESS);

        // Start broadcasting transactions using the issuer's key
        vm.startBroadcast(issuerPrivateKey);

        // 3. Create the On-Chain Identity if it doesn't already exist
        if (identityRegistry.identity(userAddress) == address(0)) {
            console.log("User does not have an identity. Creating one...");
            idFactory.createIdentity(userAddress);
            console.log("Identity creation transaction sent.");
        } else {
            console.log("User already has an identity. Skipping creation.");
        }

        // 4. Get the user's Identity contract address
        address identityAddress = identityRegistry.identity(userAddress);
        if (identityAddress == address(0)) {
            revert("Failed to retrieve identity address. The creation might have failed.");
        }
        console.log("User Identity Contract Address:", identityAddress);
        IIdentity userIdentity = IIdentity(identityAddress);

        // 5. Prepare and add the KYC claim
        // The data can be anything, e.g., a hash of off-chain documents or an expiry date.
        // For this example, we'll use an empty bytes string.
        bytes memory claimData = bytes("");

        // The identity contract requires a signature from a trusted issuer.
        // The signature is over a hash of: (identity_contract_address, topic, data)
        bytes32 dataToSign = keccak256(abi.encodePacked(identityAddress, KYC_TOPIC, claimData));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(issuerPrivateKey, dataToSign);
        bytes memory signature = abi.encodePacked(r, s, v);

        console.log("Adding KYC claim...");
        userIdentity.addClaim(
            KYC_TOPIC,
            ECDSA_SCHEME,
            issuerAddress,
            signature,
            claimData
        );
        console.log("KYC claim added successfully!");

        // Stop broadcasting
        vm.stopBroadcast();
    }
}