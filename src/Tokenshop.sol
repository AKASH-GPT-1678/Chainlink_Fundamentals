// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
//lib\chainlink-evm\contracts\src\v0.8\shared\interfaces\AggregatorV3Interface.sol

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {AkashToken} from "./AkashToken.sol";

contract TokenShop is Ownable {
    AggregatorV3Interface internal immutable i_priceFeed;
    AkashToken public immutable i_token;
    event BalanceWuthdrawn();
    error TokenShop__ZeroETHSent();
    error TokenShop__CouldNotWithdraw();

    constructor() Ownable(msg.sender) {
        i_token = new AkashToken();
        i_priceFeed = AggregatorV3Interface(
            0xbe729f2e3ad77d1aff0945a4e417f39b49e3fa08
        );
    }

    function amountToMint(uint256 amountinEth) public view returns (uint256){
        uint256 ethUsd = uint256() * 10 ** 10;
        uint256 ethAmountinUSD = amountinEth * ethUsd / 10 ** 18;
            return (ethAmountInUSD * 10 ** TOKEN_DECIMALS) / TOKEN_USD_PRICE;
    }

    receive() external payable {
        // convert the ETH amount to a token amount to mint
        if (msg.value == 0) {
            revert TokenShop__ZeroETHSent();
        }
      
        i_token.mint(msg.sender, amountToMint(msg.value));
    }
}
