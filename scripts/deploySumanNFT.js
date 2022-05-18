async function main() {
    const SumanNFT = await ethers.getContractFactory("SumanNFT")
  
    // Start deployment, returning a promise that resolves to a contract object
    const sumanNFT = await SumanNFT.deploy()
    await sumanNFT.deployed()
    console.log("Contract deployed to address:", sumanNFT.address)
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
})
  