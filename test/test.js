// We import Chai to use its asserting functions here.
const { expect } = require("chai");

describe("Token contract", function () {
  
  let Token;
  let hardhatToken;
  
  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    Token = await ethers.getContractFactory("PS");
    // Deploy the token onto the network.
    hardhatToken = await Token.deploy();
  });

  //Test for Assigning the ownership
  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      const result = await hardhatToken.owner();
    });

  });

  // Test for token Symbol
  describe("Returning Token Symbol", function () {
    it("Should Return the symbol of the token", async function () {
      const result = await hardhatToken.symbol();
      expect(result).to.equal("PSt");
    });
  })

  //Test For Token Name
  describe("Returning Name of Token", function () {
    it("Should Return the Name of the token", async function () {
      const result = await hardhatToken.name();
      expect(result).to.equal("PS");
    });
  })
  
  // Test for MintNFTUser() Function
  describe("Executing MintNFTUser Function", function () {
    it("Perform Mint Operation", async function () {
      const result = await hardhatToken.mintNFTForUser();
    });
  })

  // Test for presales Function
  describe("Executing Presales Function", function () {
    it("Perform Presales Function", async function () {
      const result = await hardhatToken.presales();
    });
  })

  // Test for totalSupply of the token into the network.
  describe("Executing Total Supply Function", function () {
    it("Should Return the supply of Token in the network", async function () {
      const result = await hardhatToken.totalSupply();
    });
  })

  //Testing the Pause Function. 
  describe("Executing Pause Function", function () {
    it("Should Able to pause Operations", async function () {
      const result = await hardhatToken.paused();
    });
  })

});