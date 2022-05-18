// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract KittyCards is ERC721("KittyCards", "KIT"), Ownable, ReentrancyGuard {
    uint256 public supply = 160;
    uint256 private nftPrice = 700000000000000;
    uint256 private _currentId = 0;
    mapping(address => bool) public minted;
    string public baseURI = "https://api.coolcatsnft.com/cat/";

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function updateURI(string memory _URI) external onlyOwner {
        baseURI = _URI;
    }

    function incrementCurrentId() private {
        _currentId++;
    }

    function mintNFT() external payable nonReentrant {
        require(msg.value == nftPrice, "Incorrect payment amount");
        (bool sent,) = owner().call{value: msg.value}("");
        require(sent, "Unable to pay ethers to owner");
        require(minted[msg.sender] == false, "Minted already");
        incrementCurrentId();
        require(_currentId <= supply, "Total supply reached");
        minted[msg.sender] = true;
        _safeMint(msg.sender, _currentId);
    }
}