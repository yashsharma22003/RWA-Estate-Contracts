// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../lib/ERC-3643/contracts/token/IToken.sol";
import "../lib/ERC-3643/contracts/registry/interface/IIdentityRegistry.sol";

contract ManageToken is Script {
    // === CONFIGURATION (Addresses from your deployment log) ===
    address public constant TOKEN_PROXY_ADDRESS = 0x83a4e0d7167ADf7993524988C2C86A3EB02F59d6;
    address public constant IDENTITY_REGISTRY_PROXY_ADDRESS = 0x7d8954abBb585EFAB5D9CCE7E36C818dFC3aC4E3;

    // Get private keys from your Anvil node
    uint256 ownerPrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 agentPrivateKey = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;
    uint256 userAPrivateKey = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;

    // Corresponding addresses for clarity in logs
    address owner = vm.addr(ownerPrivateKey);
    address agent = vm.addr(agentPrivateKey);
    address userA = vm.addr(userAPrivateKey);
    address userB = vm.addr(0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6);

    // Contract instances
    IToken token = IToken(TOKEN_PROXY_ADDRESS);
    IIdentityRegistry identityRegistry = IIdentityRegistry(IDENTITY_REGISTRY_PROXY_ADDRESS);

    function run() external {
        console.log("--- Starting Verification & Management for Token:", TOKEN_PROXY_ADDRESS, "---");

        // --- 1. Verify Initial State ---
        verifyInitialState();

        // --- 2. Register Identities ---
        registerIdentities();

        // --- 3. Perform On-Chain Actions ---
        vm.startBroadcast(agentPrivateKey);
        unpauseToken();
        mintTokens();
        vm.stopBroadcast();

        // --- 4. Perform a Transfer ---
        performTransfer();

        // --- 5. Final State Verification ---
        verifyFinalState();

        console.log("\n--- Token Management Script Finished Successfully ---");
    }
    
    function registerIdentities() internal {
        console.log("\n--- [Phase 2] Registering Identities ---");

        vm.startBroadcast(ownerPrivateKey);
        console.log("Action: Owner is adding", agent, "as an agent on the Identity Registry...");
        // identityRegistry.addAgent(agent);
        vm.stopBroadcast();

        vm.startBroadcast(agentPrivateKey);
        console.log("Action: Agent", agent, "is registering User A...");
        // identityRegistry.registerIdentity(userA, address(0), 840);
        
        console.log("Action: Agent", agent, "is registering User B...");
        // identityRegistry.registerIdentity(userB, address(0), 840);

        vm.assertTrue(identityRegistry.isVerified(userA), "FAIL: User A should be verified.");
        vm.assertTrue(identityRegistry.isVerified(userB), "FAIL: User B should be verified.");
        console.log("Identities for User A and User B are now registered and verified.");
        vm.stopBroadcast();
    }

    function verifyInitialState() internal view {
        console.log("\n--- [Phase 1] Verifying Initial State ---");
        vm.assertEq(token.owner(), owner, "FAIL: Initial owner is incorrect.");
        vm.assertTrue(token.paused(), "FAIL: Token should be paused initially.");
        vm.assertEq(token.totalSupply(), 0, "FAIL: Initial total supply should be 0.");
        console.log("Initial state is correct (Paused, 0 supply).");
    }

    function unpauseToken() internal {
        console.log("\n--- [Phase 3] Unpausing Token ---");
        console.log("Action: Agent", agent, "is unpausing the token...");
        token.unpause();
        vm.assertEq(token.paused(), false, "FAIL: Token did not unpause.");
        console.log("Token is now UNPAUSED.");
    }

    function mintTokens() internal {
        console.log("\n--- [Phase 4] Minting New Tokens ---");
        uint256 mintAmount = 1000 * 1e18;
        console.log("Action: Agent", agent, "is minting", mintAmount / 1e18, "tokens to User A...");
        token.mint(userA, mintAmount);
        vm.assertEq(token.balanceOf(userA), mintAmount, "FAIL: Minting failed, balance is incorrect.");
        console.log("Mint successful. User A balance:", token.balanceOf(userA) / 1e18);
    }

    function performTransfer() internal {
        console.log("\n--- [Phase 5] Performing a Transfer ---");
        uint256 transferAmount = 250 * 1e18;
        console.log("Action: User A", userA, "is transferring", transferAmount / 1e18, "tokens to User B...");
        
        vm.startBroadcast(userAPrivateKey);
        token.transfer(userB, transferAmount);
        vm.stopBroadcast();
        
        console.log("Transfer successful.");
    }

    function verifyFinalState() internal view {
        console.log("\n--- [Phase 6] Verifying Final State ---");
        uint256 expectedUserABalance = (1000 - 250) * 1e18;
        uint256 expectedUserBBalance = 250 * 1e18;

        vm.assertEq(token.paused(), false, "FAIL: Token should be unpaused.");
        vm.assertEq(token.balanceOf(userA), expectedUserABalance, "FAIL: User A final balance is incorrect.");
        vm.assertEq(token.balanceOf(userB), expectedUserBBalance, "FAIL: User B final balance is incorrect.");

        console.log("Final Balance User A:", token.balanceOf(userA) / 1e18);
        console.log("Final Balance User B:", token.balanceOf(userB) / 1e18);
        console.log("Final state is correct.");
    }
}