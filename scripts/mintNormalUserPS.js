require("dotenv").config()
const API_URL = process.env.API_URL
const PUBLIC_KEY = process.env.NORMAL_ACC_PUBLIC_KEY
const PRIVATE_KEY = process.env.NORMAL_ACC_PRIVATE_KEY

const { createAlchemyWeb3 } = require("@alch/alchemy-web3")
const web3 = createAlchemyWeb3(API_URL)

const contract = require("../artifacts/contracts/PS.sol/PS.json")
const contractAddress = "0xE93C817Ed22EA606B2a948C1536013013F34DBB9"
const nftContract = new web3.eth.Contract(contract.abi, contractAddress)

async function mintNFTUser(tokenURI) {
  const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, "latest") //get latest nonce

  //the transaction
  const tx = {
    from: PUBLIC_KEY,
    to: contractAddress,
    nonce: nonce,
    gas: 500000,
    data: nftContract.methods.mintNFTForUser(PUBLIC_KEY).encodeABI(),
  }

  const signPromise = web3.eth.accounts.signTransaction(tx, PRIVATE_KEY)
  signPromise
    .then((signedTx) => {
      web3.eth.sendSignedTransaction(
        signedTx.rawTransaction,
        function (err, hash) {
          if (!err) {
            console.log(
              "The hash of your transaction is: ",
              hash,
              "\nCheck Alchemy's Mempool to view the status of your transaction!"
            )
          } else {
            console.log(
              "Something went wrong when submitting your transaction:",
              err
            )
          }
        }
      )
    })
    .catch((err) => {
      console.log("Promise failed:", err)
    })
}

mintNFTUser(
  "ipfs://QmaL8L6s7NDdVmygeCVuiFVrZ3nuh7wFmrFDckzF1acep1"
)
