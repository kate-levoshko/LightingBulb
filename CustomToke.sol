// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomToken {
    string public name = "CustomToken";
    string public symbol = "CTK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10 ** uint256(decimals);
    }

    // Transfer tokens between addresses
    function transfer(address to, uint256 amount) public returns (bool) {
        // Custom logic to prevent balance check (only transfer without balance query)
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount should be greater than 0");

        _transfer(msg.sender, to, amount);
        return true;
    }

    // Approve an address to spend tokens on behalf of msg.sender
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Invalid address");
        require(amount > 0, "Amount should be greater than 0");

        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Transfer tokens on behalf of the owner
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(from != address(0), "Invalid address");
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount should be greater than 0");

        uint256 currentAllowance = allowance[from][msg.sender];
        require(currentAllowance >= amount, "Allowance exceeded");

        allowance[from][msg.sender] = currentAllowance - amount;
        _transfer(from, to, amount);

        return true;
    }

    // Internal function to handle transfers
    function _transfer(address from, address to, uint256 amount) internal {
        // This is where the logic for transferring tokens would go
        // Since we do not have balanceOf, we'll just allow transfers to occur
        // without checking the sender's balance
        emit Transfer(from, to, amount);
    }

    // Mint new tokens
    function mint(uint256 amount) public {
        require(amount > 0, "Amount should be greater than 0");
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    // Burn tokens
    function burn(uint256 amount) public {
        require(amount > 0, "Amount should be greater than 0");
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
