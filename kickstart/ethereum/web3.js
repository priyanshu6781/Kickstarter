import Web3 from 'web3';

// const web3 = new Web3(window.web3.currentProvider);

let web3;

if (typeof window !== "undefined" && typeof window.ethereum !== "undefined") {
    // we are in the browser and metamask is running
    window.ethereum.request({ method: "eth_requestAccounts" });
    web3 = new Web3(window.ethereum);
} else {
    // we are on the browser or the user is not running metamask
    const provider = new Web3.providers.HttpProvider(
        'https://rinkeby.infura.io/v3/014ad5d1ded3455084e2d4ace5802b6b'
    );
    web3 = new Web3(provider);
}

export default web3;
