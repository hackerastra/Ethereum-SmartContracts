async function main() {
    const PS = await ethers.getContractFactory("PS")
  
    // Start deployment, returning a promise that resolves to a contract object
    const psNFT = await PS.deploy()
    await psNFT.deployed()
    console.log("Contract deployed to address:", psNFT.address)
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
})