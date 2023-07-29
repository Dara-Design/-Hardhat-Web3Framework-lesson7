const networkConfig = {
    31337: {
        name: localhost,
    },
    11155111: {  //number is network id
        name: "sepolia",
        ethUsdPriceFeed: "0x694AA1769357215DE4FAC081bf1f309aDC325306",
       // https://docs.chain.link/data-feeds/price-feeds/addresses  where we find prices for different networks
    },
}

const developmentChains = ['hardhat', 'localhost']

module.exports = {
    networkConfig,
    developmentChains
}