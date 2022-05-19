//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract PS is  ERC721Enumerable, Ownable, Pausable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string public _baseTokenURI = "https://blockchainzenlabs.zensar.com/tokens/";
    uint256 public _supplyInNetwork = 50;
    uint256 public maxVal = 30;
    uint256 private _tokenId = 0;

    
    constructor() ERC721("PS", "PSt") {}
 
    //this function will allow the user to perform mint ops upto token ID 30
    function mintNFTForUser(address recipient)
        public returns (uint256) 
    {
        uint256 supply = totalSupply();
        uint256 tokenID = supply + 1;
        require(supply<31,"Error - 30 NFT already minted");
        _mint(recipient, tokenID);
        return tokenID;
    } 

    //this function will allow admin to perform mint Ops 5 in a single call 
    function presales(address recipient)
        public onlyOwner
        returns (uint256)
    {
        for(uint i=0;i<5;i++){
        uint256 supply = totalSupply();
        uint256 tokenID = supply + 1;
        require(supply<51,"Error - Max. of 50 NFT's already minted");
        _mint(recipient, tokenID);
        return tokenID;
        }
    } 

   
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

}