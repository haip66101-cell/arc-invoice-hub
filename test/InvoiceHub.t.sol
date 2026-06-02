// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../src/InvoiceHub.sol";

contract MockUSDC {
    string public name = "Mock USDC";
    string public symbol = "USDC";
    uint8 public decimals = 6;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    function mint(address to, uint256 amount) external { balanceOf[to] += amount; }
    function approve(address spender, uint256 amount) external returns (bool) { allowance[msg.sender][spender] = amount; return true; }
    function transfer(address to, uint256 amount) external returns (bool) { require(balanceOf[msg.sender] >= amount); balanceOf[msg.sender] -= amount; balanceOf[to] += amount; return true; }
    function transferFrom(address from, address to, uint256 amount) external returns (bool) { require(balanceOf[from] >= amount); require(allowance[from][msg.sender] >= amount); allowance[from][msg.sender] -= amount; balanceOf[from] -= amount; balanceOf[to] += amount; return true; }
}

contract InvoiceHubTest is Test {
    InvoiceHub app;
    MockUSDC usdc;
    address alice = address(0xA11CE);
    address bob = address(0xB0B);
    function setUp() public { usdc = new MockUSDC(); app = new InvoiceHub(address(usdc)); usdc.mint(alice, 1000e6); }
    function testPay() public { vm.startPrank(alice); usdc.approve(address(app), 25e6); app.pay(bob, 25e6, "demo"); vm.stopPrank(); assertEq(usdc.balanceOf(bob), 25e6); assertEq(app.totalVolume(), 25e6); }
}
