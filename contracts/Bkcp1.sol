//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is  ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string public _baseTokenURI = "https://api.coolcatsnft.com/cat/";
    uint256 private _reserved = 30;
    uint256 private _price = 0.00008 ether;
    address private admin = 0x0E200D2C2032D03d36BdFF97cde6f1f4Af96Ac8E;

    constructor() ERC721("MyNFT", "NFT") {
        //setBaseURI(baseURI);string memory baseURI
        for(uint i=0;i<10;i++){
            _tokenIds.increment();
            uint newItemId = _tokenIds.current();
            _safeMint(admin, newItemId);
        }
    }
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }
    function mintNFT1(uint num) public payable{
        _tokenIds.increment();
        require(num< 21, "There are maximum of 20 NFT's after the deployment");
        require(msg.value >= _price*num,"Sent ether is not correct");
        for(uint i=0;i<num;i++){
            uint newItemId = _tokenIds.current();
            _safeMint( msg.sender, newItemId);
            _tokenIds.increment();
        }
    }
}