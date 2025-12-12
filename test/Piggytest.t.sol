// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/PiggyBank.sol";

contract PiggyBankTest is Test {
    PiggyBank public piggyBank;
    address user = address(1);

    function setUp() public {
        piggyBank = new PiggyBank();
        vm.deal(user, 10 ether); // Give test user ETH
    }

    function test_Deposit() public {
        // User deposits 2 ETH
        vm.prank(user);
        piggyBank.deposit{value: 2 ether}();

        // Check internal balance variable
        assertEq(piggyBank.balance(), 2 ether);

        // Check actual ETH inside contract
        assertEq(address(piggyBank).balance, 2 ether);
    }

    function test_GetBalance() public {
        // User deposits 1 ETH
        vm.prank(user);
        piggyBank.deposit{value: 1 ether}();

        uint256 bal = piggyBank.getBalance();
        assertEq(bal, 1 ether);
    }

    function test_DepositFailsIfNoETH() public {
        // Deposit 0 ETH should fail
        vm.prank(user);
        vm.expectRevert("Send ETH");
        piggyBank.deposit{value: 0}();
    }

   
}
