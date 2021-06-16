// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";
//import "@openzeppelin/contracts/utils/Address.sol";

contract Faucet {

    Token private _token;
    string private _name;
    uint256 private _tokenAmount = 100;

    event Bought (address indexed sender, uint256 amount);

    constructor (address tokenAddress_, string memory name_ ) {
        _token = Token(tokenAddress_);
        _name = name_;
    }

    function sendToken () public {
        _token.transferFrom(_token.owner(), msg.sender, _tokenAmount);
        emit Bought (msg.sender, _tokenAmount);
    }


}