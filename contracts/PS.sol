//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract PS is  ERC721Enumerable, Ownable, ReentrancyGuard, Pausable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string public baseTokenURI = "https://api.coolcatsnft.com/cat/";
    constructor() ERC721("PS", "PSt") {
    }
 
    //this function will allow the user to perform mint ops upto token ID 30
    // user also need to send 0.0003 Ether to admin during mint ops 
    function mintNFTForUser() external payable nonReentrant whenNotPaused{
        require(getBalance(msg.sender) > msg.value,"Error");
        (bool sent,) = owner().call{value: msg.value}("");
        require(sent, "Failed to Send Ethers");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        require(newItemId < 51, "Limit Reached");
        _safeMint(msg.sender, newItemId);
    }

    //this function will allow admin to perform mint Ops 5 in a single call 
    
    function presales()
        public onlyOwner{
        for(uint i=0;i<5;++i){
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(owner(),newItemId);
        }
    } 


    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        baseTokenURI = baseURI;
    }

    function getBalance(address recipient) public view returns (uint256) {
    return address(recipient).balance;
    }
}
