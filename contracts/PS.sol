//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PS is  ERC721Enumerable, Ownable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string public _baseTokenURI = "https://api.coolcatsnft.com/cat/";
    address private _owner = address(uint160(0xb55Fd66a86612976d79010C2F6B90275b241F1f8));
    uint256 private _ethAmount = 0.0003 ether;
    bool private paused;
 
    constructor() ERC721("PS", "PSt") {
    }
 
    
    //this function will allow the user to perform mint ops upto token ID 30
    // user also need to send 0.0003 Ether to admin during mint ops 
    function mintNFTForUser(address recipient)
        public payable returns (uint256) 
    {
        require(paused==false,"Contract Paused !!");
        sendEther();
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        require(totalSupply()<31,"Error - 30 NFT already minted. !!");
        _mint(recipient, newItemId);
        return newItemId;
    } 

    //this function will allow admin to perform mint Ops 5 in a single call 
    function presales(address recipient)
        public onlyOwner
        
    {
        for(uint i=0;i<5;i++){
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        
        }
    } 

    function setPaused(bool _paused) public{
        require(msg.sender == _owner, "You are not the owner");
        paused = _paused;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }
    
    function sendEther() public payable{
         address payable _admin = payable(_owner);
        _admin.transfer(_ethAmount);
    }

}
