const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'seek lucky eagle cover bind daughter stand hollow tide metal increase tribe', 
    'https://rinkeby.infura.io/v3/b1ab7f03218445c8b3299f539e9ac6d7'
);

const web3 = new Web3(provider);
//以下步驟跟之前做的test類似

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attemting to deplu from account: ', accounts[0])
    
    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode})
        .send({ gas: '1000000', from: accounts[0] });

    console.log('Contract deployed to ', result.options.address);
};
deploy();
