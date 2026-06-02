// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract InvoiceHub {
    IERC20 public immutable usdc;
    address public owner;
    uint256 public totalVolume;
    mapping(address => uint256) public paid;
    event Paid(address indexed payer, address indexed recipient, uint256 amount, string memo);
    event Withdrawn(address indexed to, uint256 amount);

    constructor(address _usdc) {
        usdc = IERC20(_usdc);
        owner = msg.sender;
    }

    modifier onlyOwner() { require(msg.sender == owner, 'NOT_OWNER'); _; }

    function pay(address recipient, uint256 amount, string calldata memo) external {
        require(recipient != address(0), 'BAD_RECIPIENT');
        require(amount > 0, 'BAD_AMOUNT');
        require(usdc.transferFrom(msg.sender, recipient, amount), 'TRANSFER_FROM_FAILED');
        paid[msg.sender] += amount;
        totalVolume += amount;
        emit Paid(msg.sender, recipient, amount, memo);
    }

    function sweep(address to, uint256 amount) external onlyOwner {
        require(usdc.transfer(to, amount), 'TRANSFER_FAILED');
        emit Withdrawn(to, amount);
    }
}
