// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomNFT {
    string public name = "CustomNFT";
    string public symbol = "CNFT";

    uint256 public totalSupply;
    uint256 private nextTokenId;

    mapping(uint256 => address) public ownerOf; // Mapping from token ID to owner address
    mapping(address => mapping(address => bool)) public approvedForAll; // Mapping from owner to operator approval

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    constructor() {
        nextTokenId = 1;
    }

    // Mint a new token
    function mint(address to) public {
        require(to != address(0), "Cannot mint to zero address");
        uint256 tokenId = nextTokenId;
        ownerOf[tokenId] = to;
        nextTokenId++;

        totalSupply++; // Increase total supply
        emit Transfer(address(0), to, tokenId);
    }

    // Transfer a token to another address
    function transfer(address to, uint256 tokenId) public {
        address owner = ownerOf[tokenId];
        require(owner == msg.sender, "You are not the owner of this token");
        require(to != address(0), "Invalid recipient address");

        ownerOf[tokenId] = to;
        emit Transfer(owner, to, tokenId);
    }

    // Approve an address to transfer a specific token on behalf of the owner
    function approve(address approved, uint256 tokenId) public {
        address owner = ownerOf[tokenId];
        require(owner == msg.sender, "You are not the owner of this token");

        emit Approval(owner, approved, tokenId);
    }

    // Set or revoke operator approval (approve an address to manage all tokens of the owner)
    function setApprovalForAll(address operator, bool approved) public {
        approvedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    // Check if an address is the owner of a specific token
    function isOwner(uint256 tokenId) public view returns (address) {
        return ownerOf[tokenId];
    }

    // Check if an operator is approved to manage all tokens of an owner
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return approvedForAll[owner][operator];
    }
}
