// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "./IERC20.sol";

contract ERC20 is IERC20{
    mapping (address => uint256) private _balance;
    mapping (address => mapping (address => uint256)) private _allowerces;

    uint256 public _totalSupply;
    uint8 public _decimals;
    string public _symbol;
    string public _name;

    constructor() public{
        _name = "Republic Token";
        _symbol = "RPT";
        _decimals = 18;
        _totalSupply = 182 * 10**15 * 10**18;
        _balance[msg.sender] = _totalSupply;
        
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() override external view returns (uint256){
        return _totalSupply;
    }
    function balanceOf(address account) override external view returns (uint){
        return _balance[account];
    }
    function transfer(address recipient, uint amount) override external returns (bool){
        _balance[msg.sender] -= amount;
        _balance[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    function allowance(address owner, address spender) override external view returns (uint){
        return _allowerces[owner][spender];
    }
    function approve(address spender, uint amount) override external returns (bool){
        _allowerces[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(
        address spender,
        address recipient,
        uint amount
    ) override external returns (bool){
        _allowerces[spender][msg.sender] -= amount;
        _balance[spender] -= amount;
        _balance[recipient] += amount;
        emit Transfer(spender, recipient, amount);
        return true;
    }
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

