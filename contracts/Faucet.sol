// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";
//import "@openzeppelin/contracts/utils/Address.sol";

contract Faucet {

    Token private _token;
    string private _name;
    uint256 private _tokenAmount = 100**18;
    mapping (address => uint256) private _timeLapse;

    event Bought (address indexed sender, uint256 amount, uint256 timeLapse);
    event Deployed (string name);


    constructor(address tokenAddress_, string memory name_ ) {

        _token = Token(tokenAddress_);
        _name = name_;
        emit Deployed (_name);
    }

    function sendToken () public {
        if(_timeLapse[msg.sender] == 0) {
            _timeLapse[msg.sender] = block.timestamp;
        }else{
            require(block.timestamp > (_timeLapse[msg.sender] + 3 days) , "Faucet: await 3 days");
            _timeLapse[msg.sender] = block.timestamp;
        }
        _token.transferFrom(_token.owner(), msg.sender, _tokenAmount);
        emit Bought (msg.sender, _tokenAmount , _timeLapse[msg.sender]);
    }

    function allowance () public view {
        _token.allowance(_token.owner(), msg.sender);
    }

    function balanceOf () public view {
        _token.balanceOf(msg.sender);
    }

    function decimals () public view {
        _token.decimals();
    }
    
    function name () public view {
        _token.name();
    }
    
    function owner () public view {
        _token.owner();
    }
    
    function symbol () public view {
        _token.symbol();
    }

    function totalSupply () public view {
        _token.totalSupply();
    }
}