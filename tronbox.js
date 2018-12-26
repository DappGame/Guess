module.exports = {
  networks: {
    development: {
      // For trontools/quickstart docker image
      //privateKey: '5482786353b6a90ffa2b1800be6085ab6bed71ea5265cd2b74f3bea2fa8bd068',
      privateKey: '4439d3f3a7be024a6b86c6c9dd9fafd8088d9f2653317eb96fe4fb2c5fba918f',
      consume_user_resource_percent: 30,
      fee_limit: 100000000,

      // Requires TronBox 2.1.9+ and Tron Quickstart 1.1.16+
      // fullHost: "http://127.0.0.1:9090",

      // The three settings below for TronBox < 2.1.9
      //fullNode: "http://127.0.0.1:8089",
      //solidityNode: "http://127.0.0.1:8091",
      //eventServer: "http://127.0.0.1:8092",

      fullNode: "https://api.shasta.trongrid.io",
      solidityNode: "https://api.shasta.trongrid.io",
      eventServer: "https://api.shasta.trongrid.io",

      network_id: "*"
    }
  }
}
