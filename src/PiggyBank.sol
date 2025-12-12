// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PiggyBank {
    uint256 public balance;

    modifier checkBalance() {
        require(msg.sender.balance > 0, "No Enough balance");
        _;
    }

      function deposit() public payable {
        require(msg.value > 0, "Send ETH"); 
        balance += msg.value;              
    }



    function getBalance() public view returns (uint256) {
        return balance;
    }


}
